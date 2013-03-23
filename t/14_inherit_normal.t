use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use InheritTest1;
use InheritTest2;

subtest "should inherit a new method from a normal class" => sub {
    my $test = InheritTest1->new;
    is $test->a, 2;
    $test->a(1);
    is $test->a, 1;
};

subtest "should inherit a new method from normal classes" => sub {
    my $test = InheritTest2->new;
    is $test->a, 2;
    $test->a(1);
    is $test->a, 1;

    is $test->b, 3;
    $test->b(2);
    is $test->b, 2;
};

done_testing;
