use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use DefaultValueTest;

subtest "should set default values"  => sub {
    my $test = DefaultValueTest->new();
    is $test->a, 1;
    isa_ok $test->b, 'A';
    is_deeply $test->c, [1, 2, 3];
    is_deeply $test->d, {a => 1, b => 2};
    is $test->e, undef;
    is $test->f, 0;
    is $test->g, undef;
    is $test->h, "";
};

done_testing;

