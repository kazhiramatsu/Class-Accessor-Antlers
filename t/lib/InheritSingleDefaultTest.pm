package InheritSingleDefaultTest;
use lib qw(t/lib);
use base qw(InheritDefault1Test);
use Mou;

has 'a' => (
    is => 'rw',
    default => 9
);

has 'b' => (
    is => 'ro',
    default => 10
);

1;
