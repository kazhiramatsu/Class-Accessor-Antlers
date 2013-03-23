package InheritBuilderTestBase1;
use Class::Accessor::Antlers;

has 'a' => (
    is => 'ro',
    builder => '_build_a' 
);

has 'b' => (
    is => 'rw',
    builder => '_build_b' 
);

has 'c' => (
    is => 'ro',
    lazy => 1,
    builder => '_build_c' 
);

has 'd' => (
    is => 'rw',
    lazy => 1,
    builder => '_build_d' 
);

sub _build_a { 5; } 
sub _build_b { 6; } 
sub _build_c { 7; } 
sub _build_d { 8; } 

1;
