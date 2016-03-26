package YouTube::Analytics::App::deploy;
use warnings;
use strict;

use MooseX::App::Command;
extends 'YouTube::Analytics::App';

use YouTube::Analytics::Schema;

sub run {
    my $self = shift;

    my $schema = $self->_schema;
    # $schema->create_ddl_dir;
    $schema->deploy({ add_drop_table => 1 });

    my $game = $schema->resultset('Games')->update_or_create(
	{
	    Game_ID => 0,
	    Game    => 'Unknown',
	}
	);
}


1;

__END__

=name ABSTRACT

Deploys database schema

=name DESCRIPTION

Deploys the database schema.

The db option needs to be set.

