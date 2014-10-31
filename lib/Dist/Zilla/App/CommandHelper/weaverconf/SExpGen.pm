package # no indexing, please
    Dist::Zilla::App::CommandHelper::weaverconf::SExpGen;

use Moose;
use namespace::autoclean;

extends 'Data::Visitor';

sub visit_value {
    my ($self, $value) = @_;
    return qq{'$value};
}

override visit_normal_hash => sub {
    my ($self) = @_;
    my $ret = super;

    return sprintf q{(list %s)},
        join(q{ },
                map { sprintf "%s %s", $_, $ret->{$_} } keys %$ret
            );
};

override visit_normal_array => sub {
    my ($self) = @_;
    return sprintf q{(list %s)}, join(q{ }, super);
};

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::App::CommandHelper::weaverconf::SExpGen

=head1 VERSION

version 0.03

=head1 AUTHOR

Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
