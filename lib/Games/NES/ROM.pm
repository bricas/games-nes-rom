package Games::NES::ROM;

=head1 NAME

Games::NES::ROM - View information about an NES game from a ROM file

=head1 SYNOPSIS

    use Games::NES::ROM;
    
    # Read in the ROM
    my $rom = Games::NES::ROM->new( 'file.nes' );

    # Access the details
    print 'PRG Banks: ', $rom->PRG_count, "\n";
    print 'CHR Banks: ', $rom->CHR_count, "\n";
    # etc...
    
    # View the CRC checksum
    print 'CRC: ', $rom->CRC;

=head1 DESCRIPTION

This module loads the details of an NES rom file. An NES
ROM file is layed out as follows:

    +-----------+---------------+---------+---------+ Header
    | NES\0x01a | [PC] [CC] X X | X X X X | X X X X | 16 Bytes
    +-----------+---------------+---------+---------+
    |                                               |
    |          PRG Banks (PC * 16384 Bytes)         |
    |                                               |
    +-----------------------------------------------+
    |                                               |
    |          CHR Banks (CC * 8192 Bytes)          |
    |                                               |
    +-----------------------------------------------+
    |                                               |
    |          Title (128 Bytes - Optional)         |
    |                                               |
    +-----------------------------------------------+

=head1 INSTALLATION

To install this module via Module::Build:

    perl Build.PL
    ./Build         # or `perl Build`
    ./Build test    # or `perl Build test`
    ./Build install # or `perl Build install`

To install this module via ExtUtils::MakeMaker:

    perl Makefile.PL
    make
    make test
    make install

=cut

use base qw( Class::Accessor::Fast );

use strict;
use warnings;

use constant HEADER_SIZE   => 16;
use constant TITLE_SIZE    => 128;
use constant TRAINER_SIZE  => 512;
use constant PRG_BANK_SIZE => 16384;
use constant CHR_BANK_SIZE => 8192;

use FileHandle;
use Digest::CRC;

our $VERSION = '0.04';

my $header_template = 'A4 C*';
my @header_fields   = qw( identifier PRG_count CHR_count mapper );

__PACKAGE__->mk_accessors( @header_fields, qw( title has_trainer trainer horizontal_mirroring vertical_mirroring VRAM SRAM PRG_banks CHR_banks CRC ) );

=head1 METHODS

=head2 new( [$filename] )

Creates a new instance of the module. An optional filename
argument may be passed to immediately load the data.

=cut

sub new {
    my $class = shift;
    my $file  = shift;
    my $self  = {};

    bless $self, $class;

    $self->load( $file ) if $file;

    return $self;
}

=head2 load( $file )

Reads the ROM structure into memory.

=cut

sub load {
    my $self = shift;
    my $file = shift;

    my $rom = FileHandle->new( $file, '<' );
    binmode( $rom );

    my $header;
    $rom->read( $header, HEADER_SIZE );

    die 'Not an NES rom' unless $header =~ /^NES/;

    my @values = unpack( $header_template, $header );

    for( 0..2 ) {
        $self->set( $header_fields[ $_ ] => $values[ $_ ] );
    }

    $self->horizontal_mirroring( $values[ 3 ] & 1 ^ 1 );
    $self->vertical_mirroring( $values[ 3 ] & 1 );
    $self->SRAM( $values[ 3 ] & 2 );
    $self->has_trainer( $values[ 3 ] & 4 );
    $self->VRAM( $values[ 3 ] & 8 );

    my $prg_count = $self->PRG_count;
    my $chr_count = $self->CHR_count;

    my $mapper = ( $values[ 3 ] & 240 ) >> 4;
    $mapper   |= ( $values[ 4 ] & 240 );

    if( $mapper != 0 and ( $prg_count == 2 or $prg_count == 1 ) and $chr_count == 1 ) {
        $mapper = 0;
    }

    $self->mapper( $mapper );

    if( $self->has_trainer ) {
        my $trainer;
        $rom->read( $trainer, TRAINER_SIZE );
        $self->trainer( $trainer );
    }

    my @prg_banks = map {
        my $data;
        $rom->read( $data, PRG_BANK_SIZE );
        $data;
    } 1..$prg_count;

    my @chr_banks = map {
        my $data;
        $rom->read( $data, CHR_BANK_SIZE );
        $data;
    } 1..$chr_count;

    $self->PRG_banks( \@prg_banks );
    $self->CHR_banks( \@chr_banks );

    my $title;
    if($rom->read( $title, TITLE_SIZE ) == 128 ) {
        $self->title( $title );
    }

    $rom->seek( HEADER_SIZE, 0 );

    my $ctx = Digest::CRC->new( type=> 'crc32' );
    $ctx->addfile( $rom );
    $self->CRC( $ctx->hexdigest );

    $rom->close;
}

=head2 sprite( $chr_bank, $index )

Returns the raw (composite) sprite in the specified 
CHR bank at the specified array index.

=cut

sub sprite {
    my $self   = shift;
    my $chr    = shift;
    my $offset = shift;

    die 'invalid CHR bank' if $chr > $self->CHR_count - 1 or $chr < 0;
    die 'invalid sprite index' if $offset > 512 or $offset < 0;
    
    my $bank      = $self->CHR_banks->[ $chr ];
    my $start     = 16 * $offset;
    my @channel_a = unpack( 'C*', substr( $bank, $start, 8 ) );
    my @channel_b = unpack( 'C*', substr( $bank, $start + 8, 8 ) );

    my $composite = '';

    for my $i ( 0..7 ) {
        for my $j ( reverse 0..7 ) {
            $composite .= pack( 'C', $self->_combine_bits( $channel_a[ $i ], $channel_b[ $i ], $j ) );
        }
    }
    
    return $composite;
}

sub _combine_bits {
    my $self = shift;
    my( $chan_a, $chan_b, $offset ) = @_;

    return ( ( $chan_a >> $offset ) & 1 ) | ( ( ( $chan_b >> $offset ) & 1 ) << 1 );
}

=head1 ACCESSORS

The following accessors are available:

=over 4

=item * identifier - sould be "NES\0x01a"

=item * PRG_count - number of PRG banks

=item * CHR_count - number of CHR banks

=item * PRG_banks - arrayref of PRG data

=item * CHR_banks - array ref of CHR data

=item * mapper - the mapper number

=item * has_trainer - is there trainer data?

=item * trainer - the trianer data

=item * horizontal_mirroring - does it use horizontal mirroring?

=item * vertical_mirroring - does it use veritcal mirroring?

=item * VRAM - uses VRAM?

=item * SRAM - uses SRAM?

=item * CRC - CRC checksum

=item * title - game title if available 

=back

=head1 SEE ALSO

=over 4

=item * http://www.sadistech.com/nesromtool/romdoc.html

=back

=head1 AUTHOR

=over 4 

=item * Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=back

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
