package InheritLazyTestBase2;
use Class::Accessor::Antlers;

has 'a' => (
    is => 'rw',
    lazy => 1,
    default => 5
);

has 'b' => (
    is => 'ro',
    lazy => 1,
    default => 6
);

has 'e' => (
    is => 'rw',
    default => 7
);

has 'f' => (
    is => 'ro',
    default => 8
);

1;
