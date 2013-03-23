use lib qw(t/lib);
use Test::More;
use Test::Exception::LessClever;
use Mou;

subtest "should occur an exception" => sub {
    throws_ok {
        has 'a' => (
            is => 'rw',
            lazy => 1
        );
    } qr/You cannot have a lazy attribute \(a\) without specifying a default value for it/;

    throws_ok {
        has ;
    } qr/You must provide a name for the attribute/;

    throws_ok {
        has 'b' => (

        );
    } qr/Attribute \(b\) of class main has no associated methods \(did you mean to provide an "is" argument\?\)/;

    throws_ok {
        has 'c' => (
            is => 'rw',   
            lazy => 1,
            default => 1,
            builder => sub {
                1;
            }
        );
    } qr/builder must be a defined scalar value which is a method name/;

    throws_ok {
        has 'd' => (
            is => 'rw',   
            lazy => 1,
        );
    } qr/You cannot have a lazy attribute \(d\) without specifying a default value for it/;
};

done_testing;
