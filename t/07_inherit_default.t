use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use Test::Exception::LessClever;
use InheritSingleDefaultTest;
use InheritMultiDefaultTest;

subtest "should inherit a default value from a parent class"  => sub {
    my $test = InheritSingleDefaultTest->new;
    is $test->a, 9; 
    is $test->b, 10; 
    is $test->c, 3; 
    is $test->d, 4; 
};

subtest "should inherit a default value from parent classes"  => sub {
    my $test = InheritMultiDefaultTest->new;
    is $test->a, 11; 
    is $test->b, 12; 
    is $test->c, 3; 
    is $test->d, 4; 
    is $test->e, 7; 
    is $test->f, 8; 
};

done_testing;

