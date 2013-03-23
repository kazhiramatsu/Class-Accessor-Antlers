package InheritSingleRequiredTest;
use lib qw(t/lib);
use base qw(InheritRequired1Test);
use Mou;

has 'a' => (
    is => 'rw',
    required => 1 
);

has 'b' => (
    is => 'ro',
    required => 1 
);

1;
