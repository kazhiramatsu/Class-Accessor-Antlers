package Class::Accessor::Antlers;
use strict;
use warnings;
use 5.008_008;
our $VERSION = 0.01;
use MRO::Compat;

sub import {

    strict->import;
    warnings->import;

    my $caller = caller;
    my $META = {};

    add_method(
        $caller,
        'has',
        sub {
            my $attr = shift
                or croak("You must provide a name for the attribute");

            my %args = @_;
            my $is = $args{is};
            if (not defined $is) {
                croak(
                    "Attribute ($attr) of class main has no associated methods (did you mean to provide an \"is\" argument?)"
                );
            }
            unless ($is eq 'rw' || $is eq 'ro') {
                croak("I do not understand this option (is => $is) on attribute ($attr)");
            }

            $META->{$attr}->{required} = 1 if $args{required};

            for my $v (qw(default builder)) {
                my $exists = exists $args{$v};
                $META->{$attr}->{"${v}_exists"} = $exists;
                $META->{$attr}->{$v} = $args{$v} if $exists;
            }

            my $lazy = $args{lazy};
            $META->{$attr}->{lazy} = 1 if $lazy;

            if ($lazy) {
                if ((not exists $args{default}) && (not exists $args{builder})) {
                    croak(
                        "You cannot have a lazy attribute ($attr) without specifying a default value for it"
                    );
                }
                mk_lazy_rw_accessor($caller, $attr) if $is eq 'rw';
                mk_lazy_ro_accessor($caller, $attr) if $is eq 'ro';
            } else {
                mk_rw_accessor($caller, $attr) if $is eq 'rw';
                mk_ro_accessor($caller, $attr) if $is eq 'ro';
            }
        }
    );

    add_method(
        $caller,
        'new',
        sub {
            my $class = shift;
            my %args;
            if (scalar @_  == 1) {
                unless (defined $_[0] && ref $_[0] eq 'HASH') {
                    croak("Single parameters to new() must be a HASH ref");
                }
                %args = %{$_[0]};
            } else {
                %args = @_;
            }
            my $self = instantiate($class, \%args);
        }
    ) unless $caller->can('new'); 

    add_method(
        $caller,
        'meta',
        sub {
            $META; 
        }
    );
}

sub instantiate {
    my ($class, $args) = @_;

    my $self = bless {}, $class;
    map {$self->{$_} = $args->{$_};} keys %{$args};
    my $seen = {};
    my $isa = mro::get_linear_isa($class);
    my @isa = @$isa;
    while (@isa > 0) {
        my $class = shift @isa;
        next if $class =~ /^Exporter$/;
        next unless $class->can('meta');
        my $meta = $class->meta;
        $self = init_with_default_or_builder($self, $meta, $seen, $args);
    }
    $self;
}

sub init_with_default_or_builder {
    my ($self, $meta, $seen, $args) = @_;

    for my $name (sort keys %$meta) {
        next if $seen->{$name};
        $seen->{$name} = 1;
        my $attr = $meta->{$name};
        my $builder_exists = $attr->{builder_exists};
        my $default_exists = $attr->{default_exists};
        if ($attr->{required}) {
            if ((not $builder_exists) && (not $default_exists)) {
                croak("Attribute ($name) is required") unless exists $args->{$name};
            }
        }
        next if $attr->{lazy};
        next if exists $self->{$name};
        my $builder = $attr->{builder};
        my $default = $attr->{default};

        if ($builder_exists) {
            croak("builder must be a defined scalar value which is a method name") if ref $builder;
            $self->{$name} = $self->$builder();
        } elsif ($default_exists) {
            if (ref $default eq 'CODE') {
                $self->{$name} = $default->($self);
            } else {
                $self->{$name} = $default;
            }
        }
    }
    $self;
}

sub add_method {
    my ($pkg, $name, $code) = @_;
    no strict 'refs';
    my $e = eval {*{"${pkg}::${name}"} = $code;} ;
}

sub mk_lazy_ro_accessor {
    my ($pkg, $name) = @_;

    add_method(
        $pkg,
        $name,
        _mk_lazy_ro_accessor($pkg, $name)
    );
}

sub _mk_lazy_ro_accessor {
    my ($pkg, $name) = @_;

    my $attr = $pkg->meta->{$name};
    if ($attr->{builder_exists}) {
        croak("builder must be a defined scalar value which is a method name") if ref $attr->{builder};
        return _mk_lazy_ro_accessor_with_builder($name, $attr->{builder});
    } else { 
        return _mk_lazy_ro_accessor_with_default($name, $attr->{default});
    }
}

sub _mk_lazy_ro_accessor_with_builder {
    my ($name, $builder) = @_;
    sub {
        if (scalar @_ == 1) {
            unless (exists $_[0]->{$name}) {
                $_[0]->{$name} = $_[0]->$builder();
            }
            return $_[0]->{$name};
        }
        croak("Cannot assign a value to a read-only accessor of $name");
    };
}

sub _mk_lazy_ro_accessor_with_default {
    my ($name, $default) = @_;
    sub {
        if (scalar @_ == 1) {
            unless (exists $_[0]->{$name}) {
                if (ref $default eq 'CODE') {
                    $_[0]->{$name} = $default->($_[0]);
                } else {
                    $_[0]->{$name} = $default;
                }
            }
            return $_[0]->{$name};
        }
        croak("Cannot assign a value to a read-only accessor of $name");
    };
}

sub _mk_ro_accessor {
    my ($name) = @_;
    sub {
        if (scalar @_ == 1) {
            return $_[0]->{$name};
        }
        croak("Cannot assign a value to a read-only accessor of $name");
    };

}

sub mk_lazy_rw_accessor {
    my ($pkg, $name) = @_;

    add_method(
        $pkg,
        $name,
        _mk_lazy_rw_accessor($pkg, $name)
    );
}

sub _mk_lazy_rw_accessor {
    my ($pkg, $name) = @_;

    my $attr = $pkg->meta->{$name};
    if ($attr->{builder_exists}) {
        croak("builder must be a defined scalar value which is a method name") if ref $attr->{builder};
        _mk_lazy_rw_accessor_with_builder($name, $attr->{builder});
    } else {
        _mk_lazy_rw_accessor_with_default($name, $attr->{default});
    }
}

sub _mk_lazy_rw_accessor_with_builder {
    my ($name, $builder) = @_;
    sub {
        if (scalar @_ == 1) {
            unless (exists $_[0]->{$name}) {
                $_[0]->{$name} = $_[0]->$builder();
            }
            return $_[0]->{$name};
        }
        if (scalar @_ == 2) {
            $_[0]->{$name} = $_[1];
        } elsif (scalar @_ > 2) {
            $_[0]->{$name} = [ @_[1..$#_] ];
        }
    };
}

sub _mk_lazy_rw_accessor_with_default {
    my ($name, $default) = @_;
    sub {
        if (scalar @_ == 1) {
            unless (exists $_[0]->{$name}) {
                if (ref $default eq 'CODE') {
                    $_[0]->{$name} = $default->($_[0]);
                } else {
                    $_[0]->{$name} = $default;
                }
            }
            return $_[0]->{$name};
        }
        if (scalar @_ == 2) {
            $_[0]->{$name} = $_[1];
        } elsif (scalar @_ > 2) {
            $_[0]->{$name} = [ @_[1..$#_] ];
        }
    };
}

sub _mk_rw_accessor {
    my ($name) = @_;
    sub {
        if (scalar @_ == 1) {
            return $_[0]->{$name};
        }
        if (scalar @_ == 2) {
            $_[0]->{$name} = $_[1];
        } elsif (scalar @_ > 2) {
            $_[0]->{$name} = [ @_[1..$#_] ];
        }
    };
}

sub mk_rw_accessor {
    my ($pkg, $name) = @_;

    add_method(
        $pkg,
        $name,
        _mk_rw_accessor($name)
    );
}

sub mk_ro_accessor {
    my ($pkg, $name) = @_;

    add_method(
        $pkg,
        $name,
        _mk_ro_accessor($name)
    );
}

sub croak {
    my $mess = shift;
    require Carp;
    Carp::croak($mess); 
}

1;
=encoding utf8

=head1 NAME

Class::Accessor::Antlers - Yet Another Accessor Generator 

=head1 SYNOPSIS

  package Point;
  use Class::Accessor::Antlers;

  has 'x' => (
      is => 'rw',
      lazy => 1,
      default => 100
  );

  has 'y' => (
      is => 'rw',
      lazy => 1,
      builder => '_build_y'
  );

  sub _build_y {
    my $slf = shift;
    100;
  }

  has 'z' => (
      is => 'rw',
      lazy => 1,
      default => sub {
          my $self = shift;
          $self->x * $self->y;
      }
  );

  has 'w' => (
      is => 'rw',
      lazy => 1,
      default => sub {
          my $self = shift;
          $self->z * -1;
      }
  );

=head1 DESCRIPTION

This module is an variant of accessor generator.
The syntax is an minimal subset of Moose.

=head1 FUNCTIONS

=head2 has 

  has 'x' => (
      is => 'rw',
      required => 1,
      lazy = 1,
      default => 100
  );

Only the following syntax is supported. 

=over

=item is => rw|ro

=item required => Bool

=item default => Scalar|Code

=item lazy => Bool

=item builder => Str

=back 

=head2 new 

Automatically imported.
Parameters must be hash or hash ref.

  my $point = Point->new;
  my $point = Point->new(a => 1, b => 2, c => 3);
  my $point = Point->new({a => 1, b => 2, c => 3});

=head1 AUTHOR

Kazutake Hiramatsu E<lt>hiramatsu {at} cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2013 - Kazutake Hiramatsu

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

