package YouTube::Analytics::App::import_view;
use warnings;
use strict;

use MooseX::App::Command;
extends 'YouTube::Analytics::App';

use Text::CSV;

parameter 'file' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    documentation => 'Path to views CSV',
    );

option 'games' => (
    is => 'rw',
    isa => 'HashRef',
    default => sub {
	{
	    'Minecraft' => '^Minecraft',
	    'Star Wars Battlefront' => '^Star Wars Battlefront',
	    'Madden NFL 16' => '^Madden NFL 16',
	    'Plants vs. Zombies: Garden Warfare' => '^Plants vs. Zombies: Garden Warfare',
	    'Rocket League' => '^Rocket League',
	    'Star Wars Jedi Starfighter' => '^Star Wars Jedi Starfighter',
	    'FIFA 16' => '^FIFA 16',
	}
    },
    );

sub run {
    my $self = shift;

    my $schema = $self->_schema;

    my $csv = Text::CSV->new;

    open my $fh, "<:encoding(utf8)", $self->file
	or die "Cannot open ".$self->file.": $!";

    # read column names from first row
    $csv->column_names($csv->getline($fh));

    # snarf in the data
    while (my $row = $csv->getline($fh)) {
	## guess game
	my $game_id = 0;

	foreach my $game_name (keys %{ $self->games }) {
	    # print "Checking $row->[0] against ", $self->games->{$game_name},"\n";
	    my $regex = $self->games->{$game_name};
	    if ($row->[0] =~ /$regex/) {
		# print "$row->[0] matches $game_name\n";
		my $game = $schema->resultset('Games')->find_or_create(
		    {
			Game => $game_name,
		    },
		    # { key => 'Game_ID' },
		    );
		$game_id = $game->Game_ID;
		# print "$row->[0] matches $game_name ($game_id)\n";
	    }
	}
	
	## add to the database
	my $view = $schema->resultset('Views')->update_or_create(
	    {
		Video                                  => $row->[0],
		Video_ID                               => $row->[1],
		Video_length_minutes                   => $row->[2],
		Video_created                          => $row->[3],
		Watch_time_minutes                     => $row->[4],
		Views                                  => $row->[5],
		YouTube_Red_watch_time_minutes         => $row->[6],
		YouTube_Red_views                      => $row->[7],
		Average_view_duration_minutes          => $row->[8],
		Watch_time_hours                       => $row->[9],
		Average_percentage_viewed              => $row->[10],
		Subscriber_views                       => $row->[11],
		Subscriber_minutes_watched             => $row->[12],
		Card_clicks                            => $row->[13],
		Cards_shown                            => $row->[14],
		Clicks_per_card_shown                  => $row->[15],
		Card_teaser_clicks                     => $row->[16],
		Card_teasers_shown                     => $row->[17],
		Clicks_per_card_teaser_shown           => $row->[18],
		Your_estimated_revenue_USD             => $row->[19],
		Your_estimated_ad_revenue_USD          => $row->[20],
		Your_estimated_AdSense_revenue_USD     => $row->[21],
		Your_estimated_DoubleClick_revenue_USD => $row->[22],
		Your_transaction_revenue_USD           => $row->[23],
		Transactions                           => $row->[24],
		Your_revenue_per_transaction_USD       => $row->[25],
		Estimated_monetized_playbacks          => $row->[26],
		Playback_based_CPM_USD                 => $row->[27],
		Ad_impressions                         => $row->[28],
		CPM_USD                                => $row->[29],
		YouTube_ad_revenue_USD                 => $row->[30],
		Your_YouTube_Red_revenue_USD           => $row->[31],
		YouTube_Red_watch_time_hours           => $row->[32],
		Annotation_clicks                      => $row->[33],
		Clickable_annotations_shown            => $row->[34],
		Clicks_per_clickable_annotation_shown  => $row->[35],
		Annotation_closes                      => $row->[36],
		Closable_annotations_shown             => $row->[37],
		Close_rate                             => $row->[38],
		Annotations_shown                      => $row->[39],
		Likes                                  => $row->[40],
		Likes_added                            => $row->[41],
		Likes_removed                          => $row->[42],
		Dislikes                               => $row->[43],
		Dislikes_added                         => $row->[44],
		Dislikes_removed                       => $row->[45],
		Shares                                 => $row->[46],
		Comments                               => $row->[47],
		Videos_in_playlists                    => $row->[48],
		Videos_added_to_playlists              => $row->[49],
		Videos_removed_from_playlists          => $row->[50],
		Subscribers                            => $row->[51],
		Subscribers_gained                     => $row->[52],
		Subscribers_lost                       => $row->[53],
		Game_ID                                => $game_id,
	    }
	    );
    }
    close $fh;
}

1;

__END__

=name ABSTRACT

Import view data from CSV.

=name DESCRIPTION

Import view data from CSV.

It's important to export /lifetime/ data or your data will be
incomplete.


