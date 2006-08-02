use Test::More tests => 12;

use_ok( 'Games::NES::ROM' );

my $rom = Games::NES::ROM->new( 't/roms/test.nes' );
isa_ok( $rom, 'Games::NES::ROM' );

my $sprite = $rom->sprite( 0, 0 );
ok( $sprite );
is( length( $sprite ), 64 );

eval { $rom->sprite( -1, 0 ); };
ok( $@ );
like( $@, qr/invalid CHR bank/ );

eval { $rom->sprite( 2, 0 ); };
ok( $@ );
like( $@, qr/invalid CHR bank/ );

eval { $rom->sprite( 0, -1 ); };
ok( $@ );
like( $@, qr/invalid sprite index/ );

eval { $rom->sprite( 0, 513 ); };
ok( $@ );
like( $@, qr/invalid sprite index/ );
