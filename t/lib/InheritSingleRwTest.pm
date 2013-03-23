package InheritSingleRwTest;
use base qw(InheritRw1Test);
use Mou;

has 'a' => (
    is => 'rw',
);

has 'b' => (
    is => 'ro',
);

1;
