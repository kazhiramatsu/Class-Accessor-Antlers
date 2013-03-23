package InheritLazyTest1;
use lib qw(t/lib);
use base qw(InheritLazyTestBase1);
use Class::Accessor::Antlers;

has 'a' => (
    is => 'rw',
    lazy => 1,
    default => 9
);

has 'b' => (
    is => 'ro',
    lazy => 1,
    default => 10
);

1;
