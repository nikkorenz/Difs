use utf8;
package Difs::Schema::Result::Item;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Difs::Schema::Result::Item

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<item>

=cut

__PACKAGE__->table("item");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 brand

  data_type: 'text'
  is_nullable: 1

=head2 color

  data_type: 'text'
  is_nullable: 1

=head2 note

  data_type: 'text'
  is_nullable: 1

=head2 img

  data_type: 'text'
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  is_nullable: 1

=head2 updated

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "brand",
  { data_type => "text", is_nullable => 1 },
  "color",
  { data_type => "text", is_nullable => 1 },
  "note",
  { data_type => "text", is_nullable => 1 },
  "img",
  { data_type => "text", is_nullable => 1 },
  "created",
  { data_type => "timestamp", is_nullable => 1 },
  "updated",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 item_categories

Type: has_many

Related object: L<Difs::Schema::Result::ItemCategory>

=cut

__PACKAGE__->has_many(
  "item_categories",
  "Difs::Schema::Result::ItemCategory",
  { "foreign.item_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 categories

Type: many_to_many

Composing rels: L</item_categories> -> category

=cut

__PACKAGE__->many_to_many("categories", "item_categories", "category");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-22 01:50:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TeR2uc8xE+9e19PnAI4o2g

#
# Enable automatic date handling
#
__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

=head2 author_count
 
Return the number of authors for the current book
 
=cut
 
sub category_count {
    my ($self) = @_;
 
    # Use the 'many_to_many' relationship to fetch all of the authors for the current
    # and the 'count' method in DBIx::Class::ResultSet to get a SQL COUNT
    return $self->categories->count;
}

=head2 author_list
 
Return a comma-separated list of authors for the current book
 
=cut
 
sub category_list {
    my ($self) = @_;
 
    # Loop through all authors for the current book, calling all the 'full_name'
    # Result Class method for each
    my @names;
    foreach my $category ($self->categories) {
        push(@names, $category->id_name);
    }
 
    return join(",", @names);
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
