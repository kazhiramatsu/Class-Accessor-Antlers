package InheritTestBase2;
use strict;
use warnings;

sub new {
    my $class = shift;
    my %args = @_;
    $args{a} = 4;
    $args{b} = 6;
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

sub b {
    my ($self, $b) = @_;
    if (defined $b) {
        $self->{b} = $b;
    } else {
        return $self->{b};
    }
}

1;
