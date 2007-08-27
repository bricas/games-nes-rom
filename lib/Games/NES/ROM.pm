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

This module loads the details of an NES rom file. It supports the following
formats:

=over 4

=item * L<Universal NES Image File (UNIF)|Games::NES::ROM::Format::UNIF>

=item * L<iNES|Games::NES::ROM::Format::INES>

=back

=head1 INSTALLATION

    perl Makefile.PL
    make
    make test
    make install

=cut

use base qw( Class::Accessor::Fast );

use strict;
use warnings;

use FileHandle;

# perhaps these should be loaded with Module::Pluggable?
use Games::NES::ROM::Format::INES;
use Games::NES::ROM::Format::UNIF;

our $VERSION = '0.06';

__PACKAGE__->mk_accessors( qw( identifier PRG_count CHR_count mapper title
has_trainer trainer horizontal_mirroring vertical_mirroring VRAM SRAM
PRG_banks CHR_banks CRC revision ) );

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

    die "Unable to open ${file}: $!" unless defined $rom;

    binmode( $rom );

    my $header;
    $rom->read( $header, 4 );
    $rom->seek( 0, 0 );

    my $loaded;
    for( qw( INES UNIF ) ) {
        my $class = "Games\::NES\::ROM\::Format\::${_}";
        if( $header eq $class->MAGIC ) {
            bless $self, $class;
            $loaded = $self->_load( $rom );
            last;
        }
    }

    die 'Not an NES rom' unless $loaded;

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

=item * identifier - sould be "NES\0x01a" for iNES and "UNIF" for UNIF

=item * revision - used by UNIF

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

=item * Games::NES::ROM::Format::INES

=item * Games::NES::ROM::Format::UNIF

=back

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
