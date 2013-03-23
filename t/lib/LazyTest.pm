package LazyTest;
use Mou;

has 'a' => (
    is => 'rw',
    lazy => 1,
    default => sub {
        1;
    }
);

has 'b' => (
    is => 'rw',
    lazy => 1,
    default => 2 
);

has 'c' => (
    is => 'rw',
    lazy => 1,
    builder => '_build_c' 
);

sub _build_c {
    3;
}

has 'd' => (
    is => 'rw',
    lazy => 1,
    default => 1
);

has 'e' => (
    is => 'rw',
    lazy => 1,
    default => 0
);

has 'f' => (
    is => 'rw',
    lazy => 1,
    default => undef 
);

1;
