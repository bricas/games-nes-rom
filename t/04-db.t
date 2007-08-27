use Test::More tests => 3;

use strict;

BEGIN {
    use_ok( 'Games::NES::ROM::Database' );
}

my $db = Games::NES::ROM::Database->new;

isa_ok( $db, 'Games::NES::ROM::Database' );

my $info = $db->get_info_by_crc( '8e2bd25c' );

my $expected = {
    flags => 530,
    input => 0,
    prg_skip => 0,
    mapper => 0,
    crc => '8e2bd25c',
    chr_skip => 0,
    wrk_size => 0,
    attribute => 0,
    prg_size => 2,
    chr_size => 1
};

is_deeply( $info, $expected );
