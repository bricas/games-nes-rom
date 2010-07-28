use strict;
use warnings;

use Test::More tests => 3;

BEGIN {
    use_ok( 'Games::NES::ROM::Database' );
}

my $db = Games::NES::ROM::Database->new;

isa_ok( $db, 'Games::NES::ROM::Database' );

my $info = $db->find_by_crc( '8e2bd25c' );

my $expected = {
    cartridge => {
        sha1   => '71FDB80C3583010422652CC5AAE8E2E4131E49F3',
        dump   => 'bad',
        system => 'Famicom',
        crc    => '8E2BD25C',
        board  => {
            pad => {
                h => '1',
                v => '0'
            },
            prg    => { size => '32k' },
            chr    => { size => '8k' },
            mapper => '0'
        }
    }
};

is_deeply( $info, $expected );
