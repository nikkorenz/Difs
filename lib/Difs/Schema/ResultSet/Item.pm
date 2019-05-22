package Difs::Schema::ResultSet::Item;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 created_after
 
A predefined search for recently added items
 
=cut
 
sub created_after {
    my ($self, $datetime) = @_;
 
    my $date_str = $self->result_source->schema->storage
                          ->datetime_parser->format_datetime($datetime);
 
    return $self->search({
        created => { '>' => $date_str }
    });
}
 
1;