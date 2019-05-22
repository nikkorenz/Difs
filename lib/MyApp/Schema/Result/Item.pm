use utf8;
package MyApp::Schema::Result::Item;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Item

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

Related object: L<MyApp::Schema::Result::ItemCategory>

=cut

__PACKAGE__->has_many(
  "item_categories",
  "MyApp::Schema::Result::ItemCategory",
  { "foreign.item_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 categories

Type: many_to_many

Composing rels: L</item_categories> -> category

=cut

__PACKAGE__->many_to_many("categories", "item_categories", "category");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-22 01:23:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iIMO9EKvqSdUf0ePlexm4Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
