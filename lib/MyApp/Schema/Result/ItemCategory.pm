use utf8;
package MyApp::Schema::Result::ItemCategory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::ItemCategory

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

=head1 TABLE: C<item_category>

=cut

__PACKAGE__->table("item_category");

=head1 ACCESSORS

=head2 item_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "item_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</item_id>

=item * L</category_id>

=back

=cut

__PACKAGE__->set_primary_key("item_id", "category_id");

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<MyApp::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "MyApp::Schema::Result::Category",
  { id => "category_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 item

Type: belongs_to

Related object: L<MyApp::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "MyApp::Schema::Result::Item",
  { id => "item_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-22 01:23:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fOxC3kFGdLQlNaDm4uptgQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
