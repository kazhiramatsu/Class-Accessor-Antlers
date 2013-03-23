package InheritRequired1Test;
use Mou;

has 'a' => (
    is => 'ro',
    required => 0 
);

has 'b' => (
    is => 'rw',
    required => 0 
);

has 'c' => (
    is => 'ro',
    required => 1 
);

has 'd' => (
    is => 'rw',
    required => 1 
);

1;
