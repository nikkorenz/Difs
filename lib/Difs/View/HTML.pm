package Difs::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

Difs::View::HTML - TT View for Difs

=head1 DESCRIPTION

TT View for Difs.

=head1 SEE ALSO

L<Difs>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
