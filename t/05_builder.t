use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use BuilderTest;

subtest "should call a builder"  => sub {
    my $test = BuilderTest->new();
    is $test->a, 1;
    is $test->b, 2;
    is $test->{c}, undef;
    is $test->c, 3;
};

done_testing;

