use utf8;
package MyApp::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-22 01:23:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OWoWnJyG4l4yZ1X5R+REDQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
