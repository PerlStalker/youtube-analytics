#!/usr/bin/perl
use warnings;
use strict;

use FindBin;
use lib("$FindBin::Bin/../lib");

use YouTube::Analytics::App;
YouTube::Analytics::App->new_with_command->run;
