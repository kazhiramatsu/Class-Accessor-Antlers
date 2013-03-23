package InheritDefault2Test;
use Class::Accessor::Antlers;

has 'a' => (
    is => 'rw',
    default => 5
);

has 'b' => (
    is => 'ro',
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
