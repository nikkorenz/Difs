use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Difs';
use Difs::Controller::Items;

ok( request('/items')->is_success, 'Request should succeed' );
done_testing();
