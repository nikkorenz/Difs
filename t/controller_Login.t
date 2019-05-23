use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Difs';
use Difs::Controller::Login;

ok( request('/login')->is_success, 'Request should succeed' );
done_testing();
