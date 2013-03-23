package InheritLazyTest2;
use lib qw(t/lib);
use base qw(InheritLazyTestBase1 InheritLazyTestBase2);
use Class::Accessor::Antlers;

has 'a' => (
    is => 'rw',
    default => 11 
);

has 'b' => (
    is => 'ro',
    default => 12 
);

1;
