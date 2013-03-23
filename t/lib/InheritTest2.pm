package InheritTest2;
use base qw(InheritTestBase1 InheritTestBase2);
use Mou;

has 'a' => (
    is => 'rw',
);

1;
