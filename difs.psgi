use strict;
use warnings;

use Difs;

my $app = Difs->apply_default_middlewares(Difs->psgi_app);
$app;

