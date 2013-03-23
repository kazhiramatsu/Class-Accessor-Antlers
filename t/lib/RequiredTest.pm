package RequiredTest;
use Mou;

has 'a' => (
    is => 'rw',
    required => 1,
);

has 'b' => (
    is => 'rw',
    required => 0
);

has 'c' => (
    is => 'rw',
);

has 'd' => (
    is => 'rw',
    required => 1,
    default => 1,
);

has 'e' => (
    is => 'rw',
    required => 1,
    default => 1,
);

has 'f' => (
    is => 'rw',
    required => 1,
    default => 1,
);

has 'g' => (
    is => 'rw',
    required => 1,
    builder => '_g',
);

has 'h' => (
    is => 'rw',
    required => 1,
    builder => '_g',
);

sub _g {
    1;
}

has 'i' => (
    is => 'rw',
    required => 1,
    lazy => 1,
    default => undef 
);

1;
