use Test::More tests => 4;

use_ok( 'Games::NES::ROM' );

my $rom = Games::NES::ROM->new( 't/roms/test.nes' );
isa_ok( $rom, 'Games::NES::ROM' );

my $sprite = $rom->sprite( 0, 0 );
ok( $sprite );
is( length( $sprite ), 64 );
