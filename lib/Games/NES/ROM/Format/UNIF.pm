package Games::NES::ROM::Format::UNIF;

use strict;
use warnings;

use base qw( Games::NES::ROM );

use Digest::CRC;

use constant MAGIC => 'UNIF';

use constant HEADER_SIZE => 32;
use constant CHUNK_HEADER_SIZE => 6;

my $header_template = 'A4 V A24';
my @header_fields = qw( identifier revision filler );

my $chunk_header_template = 'A4 V';

__PACKAGE__->mk_accessors( qw( identifier revision ) );

=head1 NAME

Games::NES::ROM::Format::INES - Loads data from a ROM in UNIF format

=head1 DESCRIPTION

This module loads the details of an NES rom in UNIF format. A UNIF file is
layed out as follows:

    +----------+
    | "UNIF"   | 4 Bytes
    +----------+
    | Revision | 32-bit Word
    +----------+
    | Filler   | 24 Bytes
    +----------+
    | Chunk ID | 4 Bytes
    +----------+
    | Length   | 32-bit Word
    +----------+
    | Data     |
    +----------+
    etc...

=cut

sub _load {
    my( $self, $fh ) = @_;

    my $header;
    $fh->read( $header, HEADER_SIZE );

    my @values = unpack( $header_template, $header );

    for( 0..1 ) {
        $self->set( $header_fields[ $_ ] => $values[ $_ ] );
    }

    my $chunk_header;
    while( $fh->read( $chunk_header, CHUNK_HEADER_SIZE ) ) {
        my( $id, $length ) = unpack( $chunk_header_template, $chunk_header );
        my $chunk;
        $fh->read( $chunk, $length );

        my @args;
        if( $id =~ m{(CHR|PRG|CCK|PCK)(.)} ) {
            $id = $1;
            push @args, hex($2);
        }

        my $name = "_parse_${id}_chunk";
        if( my $sub = $self->can( $name ) ) {
            $sub->( $self, $chunk, @args );
        }
    }
    
    return 1;
}

sub _parser_NAME_chunk {
    my( $self, $data ) = @_;
    $self->title( unpack( 'A*', $data ) );
}

sub _parse_BATR_chunk {
    my( $self, $data ) = @_;
    $self->SRAM( 1 );
}

sub _parse_VROR_chunk {
    my( $self, $data ) = @_;
    $self->VRAM( 1 );
}

sub _parse_CHR_chunk {
    my( $self, $data, $id ) = @_;
    my $chr_banks = $self->CHR_banks || [];
    $chr_banks->[ $id ] = $data;
    $self->CHR_banks( $chr_banks );
}

sub _parse_PRG_chunk {
    my( $self, $data, $id ) = @_;
    my $prg_banks = $self->PRG_banks || [];
    $prg_banks->[ $id ] = $data;
    $self->PRG_banks( $prg_banks );
}

sub _parse_READ_chunk {
    my( $self, $data ) = @_;
    $self->comments( unpack( 'A*', $data ) );
}

sub _parse_TVCI_chunk {
    my( $self, $data ) = @_;
    $self->TVCI( unpack( 'C', $data ) );
}

sub _parse_CTRL_chunk {
    my( $self, $data ) = @_;
    $self->controller( unpack( 'C', $data ) );
}

sub _parse_MIRR_chunk {
    my( $self, $data ) = @_;
    $self->mirroring( unpack( 'C', $data ) );
}

=head1 SEE ALSO

=over 4

=item * Games::NES::ROM

=item * http://www.parodius.com/~veilleux/UNIF_current.txt

=back

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
