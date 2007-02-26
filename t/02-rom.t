use Test::More tests => 14;

use strict;

BEGIN {
    use_ok( 'Games::NES::ROM' );
}

my $rom = Games::NES::ROM->new;

eval { $rom->load( 't/roms/notarom.nes' ); };
ok( $@ );
like( $@, qr/Not an NES rom/ );

$rom->load( 't/roms/test.nes' );

isa_ok( $rom, 'Games::NES::ROM' );

is( $rom->identifier, 'NES' . chr( 26 ), 'identifier' );
is( $rom->VRAM, 0, 'VRAM' );
is( $rom->SRAM, 0, 'SRAM' );
is( $rom->vertical_mirroring, 1, 'vertical_mirroring' );
is( $rom->horizontal_mirroring, 0, 'horizontal_mirroring' );
is( $rom->CHR_count, 1, 'CHR_count' );
is( $rom->PRG_count, 2, 'PRG_count' );
is( $rom->mapper, 0, 'mapper' );
is( $rom->has_trainer, 0, 'has_trainer' );
is( $rom->CRC, '8e2bd25c', 'CRC' );
