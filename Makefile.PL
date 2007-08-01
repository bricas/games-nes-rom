use inc::Module::Install 0.65;

name 'Games-NES-ROM';
all_from 'lib/Games/NES/ROM.pm';

requires 'Class::Accessor::Fast';
requires 'Digest::CRC';
requires 'Test::More';

auto_install;
WriteAll;
