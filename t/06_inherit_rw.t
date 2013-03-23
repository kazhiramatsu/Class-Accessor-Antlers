use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use Test::Exception::LessClever;
use InheritSingleRwTest;
use InheritMultiRwTest;

subtest "should inherit rw attributes of a parent class"  => sub {
    my $test = InheritSingleRwTest->new(
        a => 1,
        b => 2,
        c => 3,
        d => 4,
    );

    lives_ok { $test->a; };
    is $test->a, 1;
    lives_ok { $test->a('2'); };
    is $test->a, 2;
    lives_ok { $test->b; };
    is $test->b, 2;
    throws_ok { $test->b('1'); } qr/Cannot assign a value to a read-only accessor of b/;
    lives_ok { $test->c; };
    is $test->c, 3;
    throws_ok { $test->c('1'); } qr/Cannot assign a value to a read-only accessor of c/;
    lives_ok { $test->d; };
    is $test->d, 4;
    lives_ok { $test->d('1'); };
    is $test->d, 1;

};

subtest "should inherit rw attributes of parent classes"  => sub {
    my $test = InheritMultiRwTest->new(
        a => 1,
        b => 2,
        c => 3,
        d => 4,
        e => 5,
        f => 6,
    );

    lives_ok { $test->a; };
    is $test->a, 1;
    lives_ok { $test->a('2'); };
    is $test->a, 2;
    lives_ok { $test->b; };
    is $test->b, 2;
    throws_ok { $test->b('1'); } qr/Cannot assign a value to a read-only accessor of b/;
    lives_ok { $test->c; };
    is $test->c, 3;
    throws_ok { $test->c('1'); } qr/Cannot assign a value to a read-only accessor of c/;
    lives_ok { $test->d; };
    is $test->d, 4;
    lives_ok { $test->d('1'); };
    is $test->d, 1;
    lives_ok { $test->e; };
    is $test->e, 5;
    lives_ok { $test->e('1'); };
    is $test->e, 1;
    lives_ok { $test->f; };
    is $test->f, 6;
    throws_ok { $test->f('1'); } qr/Cannot assign a value to a read-only accessor of f/;
};

done_testing;

