package InheritRequired2Test;
use Mou;

has 'a' => (
    is => 'rw',
    required => 0 
);

has 'b' => (
    is => 'ro',
    required => 0 
);

has 'e' => (
    is => 'rw',
    required => 1 
);

has 'f' => (
    is => 'ro',
    required => 1 
);

1;
