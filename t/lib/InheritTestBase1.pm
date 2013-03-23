package InheritTestBase1;
use strict;
use warnings;

sub new {
    my $class = shift;
    my %args = @_;
    $args{a} = 2;
    $args{b} = 3;
    bless \%args, $class;
}

sub a {
    my ($self, $a) = @_;
    if (defined $a) {
        $self->{a} = $a;
    } else {
        return $self->{a};
    }
}

1;
