use strict;
use warnings;
use lib qw(t/lib);
use Test::More;
use Test::Exception::LessClever;
use InheritSingleRequiredTest;
use InheritMultiRequiredTest;

subtest "should inherit required attributes from a parent class"  => sub {
    lives_ok {
        my $test = InheritSingleRequiredTest->new( 
            a => 1,
            b => 2,
            c => 3,
            d => 4
        );
        is $test->a, 1;
        is $test->b, 2;
        is $test->c, 3;
        is $test->d, 4;

    };

    throws_ok {
        my $test = InheritSingleRequiredTest->new;
    } qr/Attribute \(a\) is required/;

    throws_ok {
        my $test = InheritSingleRequiredTest->new(
            a => 1
        );
    } qr/Attribute \(b\) is required/;

    throws_ok {
        my $test = InheritSingleRequiredTest->new(
            a => 1,
            b => 2
        );
    } qr/Attribute \(c\) is required/;

    throws_ok {
        my $test = InheritSingleRequiredTest->new(
            a => 1,
            b => 2,
            c => 3
        );
    } qr/Attribute \(d\) is required/;
};

subtest "should inherit required attributes from parent classes"  => sub {
    lives_ok {
        my $test = InheritMultiRequiredTest->new( 
            a => 1,
            b => 2,
            c => 3,
            d => 4,
            e => 5,
            f => 6
        );
        is $test->a, 1;
        is $test->b, 2;
        is $test->c, 3;
        is $test->d, 4;
        is $test->e, 5;
        is $test->f, 6;
    };


    throws_ok {
        my $test = InheritMultiRequiredTest->new; 
    } qr/Attribute \(c\) is required/;

    throws_ok {
        my $test = InheritMultiRequiredTest->new( 
            a => 1
        );
    } qr/Attribute \(c\) is required/;

    throws_ok {
        my $test = InheritMultiRequiredTest->new( 
            a => 1,
            b => 2
        );
    } qr/Attribute \(c\) is required/;

    throws_ok {
        my $test = InheritMultiRequiredTest->new( 
            a => 1,
            b => 2,
            c => 3
        );
    } qr/Attribute \(d\) is required/;

    throws_ok {
        my $test = InheritMultiRequiredTest->new( 
            a => 1,
            b => 2,
            c => 3,
            d => 4,
        );
    } qr/Attribute \(e\) is required/;

    throws_ok {
        my $test = InheritMultiRequiredTest->new( 
            a => 1,
            b => 2,
            c => 3,
            d => 4,
            e => 5
        );
    } qr/Attribute \(f\) is required/;
};

done_testing;

