package InheritBuilderTestBase2;
use Class::Accessor::Antlers;

has 'a' => (
    is => 'rw',
    lazy => 1,
    builder => '_build_a' 
);

has 'b' => (
    is => 'ro',
    lazy => 1,
    builder => '_build_b' 
);

has 'e' => (
    is => 'rw',
    builder => '_build_e' 
);

has 'f' => (
    is => 'ro',
    builder => '_build_f' 
);

sub _build_a { 9; } 
sub _build_b { 10; } 
sub _build_e { 11; } 
sub _build_f { 12; } 

1;
