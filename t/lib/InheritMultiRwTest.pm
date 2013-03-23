package InheritMultiRwTest;
use lib qw(t/lib);
use base qw(InheritRw1Test InheritRw2Test);
use Mou;

has 'a' => (
    is => 'rw',
);

has 'b' => (
    is => 'ro',
);

1;
