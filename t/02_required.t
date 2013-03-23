use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use Test::Exception::LessClever;
use RequiredTest;

subtest "should call a new method with required attributes"  => sub {
    lives_ok {
        my $test = RequiredTest->new(a => 1, b => 2, c => 3);
        is $test->a, 1;
        is $test->b, 2;
        is $test->c, 3;
    };

    lives_ok {
        my $test = RequiredTest->new(a => 1);
        is $test->a, 1;
    };

};

subtest "should throw an exception for required attributes"  => sub {
    throws_ok {
        my $test = RequiredTest->new;
    } qr/Attribute \(a\) is required/;
};

done_testing;

