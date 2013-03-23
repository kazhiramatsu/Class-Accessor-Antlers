use inc::Module::Install;

name 'Class-Accessor-Antlers';
all_from 'lib/Class/Accessor/Antlers.pm';

configure_requires 'MRO::Compat';

test_requires 'Test::More';
test_requires 'Test::Exception::LessClever';

WriteAll;

