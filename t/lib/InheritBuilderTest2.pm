package InheritBuilderTest2;
use lib qw(t/lib);
use base qw(InheritBuilderTestBase1 InheritBuilderTestBase2);
use Class::Accessor::Antlers;

has 'a' => (
    is => 'rw',
    builder => '_build_a' 
);

has 'b' => (
    is => 'ro',
    builder => '_build_b' 
);

sub _build_a { 1; } 
sub _build_b { 2; } 

1;
