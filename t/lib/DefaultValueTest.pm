package DefaultValueTest;
use Class::Accessor::Antlers;
use A;

has 'a' => (
    is => 'rw',
    default => 1
);

has 'b' => (
    is => 'rw',
    default => sub {
        A->new;
    }
);

has 'c' => (
    is => 'rw',
    default => [1,2,3] 
);

has 'd' => (
    is => 'rw',
    default => {a => 1, b => 2} 
);

has 'e' => (
    is => 'rw',
    default => undef 
);

has 'f' => (
    is => 'rw',
    default => 0 
);

has 'g' => (
    is => 'rw',
    default => sub {
        undef;
    }
);

has 'h' => (
    is => 'rw',
    default => sub {
        "";
    }
);

1;
