use lib qw(t/lib);
use Test::More;
use Test::Exception::LessClever;
use NewTest;

subtest "should call a new method with correct arguments"  => sub {
    lives_ok {
        my $test = NewTest->new(a => 1, b => 2);
        is $test->a, 1;
        is $test->b, 2;
    };

    lives_ok {
        my $test = NewTest->new({a => 1, b => 2});
        is $test->a, 1;
        is $test->b, 2;
    };

    throws_ok {
        my $test = NewTest->new([1, 2]);
    } qr/Single parameters to new\(\) must be a HASH ref/;
};

done_testing;

