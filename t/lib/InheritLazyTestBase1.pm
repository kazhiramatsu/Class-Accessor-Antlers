package InheritLazyTestBase1;
use Class::Accessor::Antlers;

has 'a' => (
    is => 'ro',
    default => 1
);

has 'b' => (
    is => 'rw',
    default => 2
);

has 'c' => (
    is => 'ro',
    lazy => 1,
    default => 3
);

has 'd' => (
    is => 'rw',
    lazy => 1,
    default => 4
);

1;
