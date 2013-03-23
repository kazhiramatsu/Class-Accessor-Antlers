package BuilderTest;
use Class::Accessor::Antlers;

has 'a' => (
    is => 'rw',
    builder => '_build_a' 
);

has 'b' => (
    is => 'rw',
    builder => '_build_b' 
);

has 'c' => (
    is => 'rw',
    lazy => 1,
    builder => '_build_c' 
);

sub _build_a {
    1;
}

sub _build_b {
    2;
}

sub _build_c {
    3;
}

1;
