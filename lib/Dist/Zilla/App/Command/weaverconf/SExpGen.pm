package # no indexing, please
    Dist::Zilla::App::Command::weaverconf::SExpGen;
BEGIN {
  $Dist::Zilla::App::Command::weaverconf::SExpGen::AUTHORITY = 'cpan:FLORA';
}
BEGIN {
  $Dist::Zilla::App::Command::weaverconf::SExpGen::VERSION = '0.01';
}

use Moose;
use Moose::Autobox;
use namespace::autoclean;

extends 'Data::Visitor';

sub visit_value {
    my ($self, $value) = @_;
    return qq{'$value};
}

override visit_normal_hash => sub {
    my ($self) = @_;
    my $ret = super;
    return sprintf q{(list %s)}, $ret->keys->map(sub {
        sprintf "%s %s", $_, $ret->{$_}
    })->join(q{ });
};

override visit_normal_array => sub {
    my ($self) = @_;
    return sprintf q{(list %s)}, super->join(q{ });
};

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::weaverconf::SExpGen

=head1 AUTHOR

  Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

