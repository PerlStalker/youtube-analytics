package YouTube::Analytics::Schema::Result::Games;
use warnings;
use strict;

use base "DBIx::Class::Core";

__PACKAGE__->load_components('Core');
__PACKAGE__->load_components('PK::Auto::SQLite');

__PACKAGE__->table('games');

__PACKAGE__->add_columns(
    Game_ID => {
	data_type => 'Int',
	is_numeric => 1,
	is_auto_increment => 1,
    },
    Game => {},
    );

__PACKAGE__->set_primary_key("Game_ID");
__PACKAGE__->add_unique_constraint([ qw/Game/ ]);

## relationships
__PACKAGE__->has_many(
    views => "YouTube::Analytics::Schema::Result::Views",
    { 'foreign.Game_ID' => 'self.Game_ID' },
    );

1;
