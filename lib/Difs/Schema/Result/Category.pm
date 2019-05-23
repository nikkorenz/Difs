use utf8;
package Difs::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Difs::Schema::Result::Category

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

=head1 TABLE: C<category>

=cut

__PACKAGE__->table("category");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
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
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items

Type: many_to_many

Composing rels: L</item_categories> -> item

=cut

__PACKAGE__->many_to_many("items", "item_categories", "item");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-22 01:50:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6iQVszFfbXFp9NbCRR6FAA

#
# Row-level helper methods
#
sub id_name {
    my ($self) = @_;
 
    return $self->id . ' ' . $self->name;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
