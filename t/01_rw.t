use strict;
use warnings;
use lib qw(t/lib);
use RwTest;
use Test::More;
use Test::Exception::LessClever;

subtest "should access for rw attributes"  => sub {
    my $test = RwTest->new(a => 1, b => 2);
    lives_ok { $test->a; };
    lives_ok { $test->a('1'); };
    lives_ok { $test->b; };
};

subtest "should throws an exception for rw attributes"  => sub {
    my $test = RwTest->new(a => 1, b => 2);
    throws_ok { $test->b('1'); } qr/Cannot assign a value to a read-only accessor of b/;
};

done_testing;

