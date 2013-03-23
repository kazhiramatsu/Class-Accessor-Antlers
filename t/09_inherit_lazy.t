use lib qw(t/lib);
use Test::More;
use InheritLazyTest1;
use InheritLazyTest2;

subtest "should inherit lazy attributes from a parent class" => sub {
    my $test = InheritLazyTest1->new;
    is $test->a, 9;
    is $test->b, 10;
    is $test->c, 3;
    is $test->d, 4;
};

subtest "should inherit lazy attributes from parent classes" => sub {
    my $test = InheritLazyTest2->new;
    is $test->a, 11;
    is $test->b, 12;
    is $test->c, 3;
    is $test->d, 4;
};

done_testing;
