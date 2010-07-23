use inc::Module::Install 0.99;

name 'Games-NES-ROM';
all_from 'lib/Games/NES/ROM.pm';

requires 'Moose';
requires 'Try::Tiny';
requires 'FileHandle';

test_requires 'Test::More';

WriteAll;
