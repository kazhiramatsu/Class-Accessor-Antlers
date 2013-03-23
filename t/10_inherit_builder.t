use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use InheritBuilderTest1;
use InheritBuilderTest2;

subtest "should inherit a builder of a parent class" => sub {
    my $test = InheritBuilderTest1->new;
    is $test->{a}, undef;
    is $test->a, 1;
    is $test->{b}, undef;
    is $test->b, 2;
    is $test->{c}, undef;
    is $test->c, 7;
    is $test->{d}, undef;
    is $test->d, 8;
};

subtest "should inherit a builder of two parent classes" => sub {
    my $test = InheritBuilderTest2->new;
    is $test->{a}, 1;
    is $test->a, 1;
    is $test->{b}, 2;
    is $test->b, 2;
    is $test->{c}, undef;
    is $test->c, 7;
    is $test->{d}, undef;
    is $test->d, 8;
    is $test->{e}, 11;
    is $test->e, 11;
    is $test->{f}, 12;
    is $test->f, 12;
};

done_testing;
