use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use LazyTest;

subtest "should call lazy accessors"  => sub {
    my $test = LazyTest->new();
    is $test->{a}, undef; 
    is $test->a, 1;
    is $test->{b}, undef;
    is $test->b, 2;
    is $test->{c}, undef;
    is $test->c, 3;
    is $test->{d}, undef;
    is $test->d, 1;
    is $test->{e}, undef;
    is $test->e, 0;
    is $test->{f}, undef;
    is $test->f, undef;
};

done_testing;

