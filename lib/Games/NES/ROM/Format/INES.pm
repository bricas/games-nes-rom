package Games::NES::ROM::Format::INES;

use strict;
use warnings;

use base qw( Games::NES::ROM );

use Digest::CRC;

use constant MAGIC => "NES\x1a";

use constant HEADER_SIZE   => 16;
use constant TITLE_SIZE    => 128;
use constant TRAINER_SIZE  => 512;
use constant PRG_BANK_SIZE => 16384;
use constant CHR_BANK_SIZE => 8192;

my $header_template = 'A4 C*';
my @header_fields   = qw( identifier PRG_count CHR_count mapper );

=head1 NAME

Games::NES::ROM::Format::INES - Loads data from a ROM in iNES format

=head1 DESCRIPTION

This module loads the details of an NES rom in iNES format. An iNES file is
layed out as follows:

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

=cut

sub _load {
    my( $self, $fh ) = @_;

    my $header;
    $fh->read( $header, HEADER_SIZE );

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
        $fh->read( $trainer, TRAINER_SIZE );
        $self->trainer( $trainer );
    }

    my @prg_banks = map {
        my $data;
        $fh->read( $data, PRG_BANK_SIZE );
        $data;
    } 1..$prg_count;

    my @chr_banks = map {
        my $data;
        $fh->read( $data, CHR_BANK_SIZE );
        $data;
    } 1..$chr_count;

    $self->PRG_banks( \@prg_banks );
    $self->CHR_banks( \@chr_banks );

    my $title;
    if( $fh->read( $title, TITLE_SIZE ) == 128 ) {
        $self->title( $title );
    }

    $fh->seek( HEADER_SIZE, 0 );

    my $ctx = Digest::CRC->new( type=> 'crc32' );
    $ctx->addfile( $fh );
    $self->CRC( $ctx->hexdigest );

    return 1;
}

=head1 SEE ALSO

=over 4

=item * Games::NES::ROM

=item * http://www.sadistech.com/nesromtool/romdoc.html

=back

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
