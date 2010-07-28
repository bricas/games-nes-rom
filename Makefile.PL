use inc::Module::Install 0.99;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Games/NES/ROM.pm > README' );
}

perl_version '5.008';

name 'Games-NES-ROM';
all_from 'lib/Games/NES/ROM.pm';

requires 'Moose';
requires 'Try::Tiny';
requires 'FileHandle';

test_requires 'Test::More';

WriteAll;
