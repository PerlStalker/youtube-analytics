package YouTube::Analytics::Schema::Result::Views;
use warnings;
use strict;

use base "DBIx::Class::Core";

__PACKAGE__->table('views');
__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->add_columns(
    Video => {},
    Video_ID => {},
    Video_length_minutes => {},
    Video_created => {},
    Watch_time_minutes => {},
    Views => {},
    YouTube_Red_watch_time_minutes => {},
    YouTube_Red_views => {},
    Average_view_duration_minutes => {},
    Watch_time_hours => {},
    Average_percentage_viewed => {},
    Subscriber_views => {},
    Subscriber_minutes_watched => {},
    Card_clicks => {},
    Cards_shown => {},
    Clicks_per_card_shown => {},
    Card_teaser_clicks => {},
    Card_teasers_shown => {},
    Clicks_per_card_teaser_shown => {},
    Your_estimated_revenue_USD => {},
    Your_estimated_ad_revenue_USD => {},
    Your_estimated_AdSense_revenue_USD => {},
    Your_estimated_DoubleClick_revenue_USD => {},
    Your_transaction_revenue_USD => {},
    Transactions => {},
    Your_revenue_per_transaction_USD => {},
    Estimated_monetized_playbacks => {},
    Playback_based_CPM_USD => {},
    Ad_impressions => {},
    CPM_USD => {},
    YouTube_ad_revenue_USD => {},
    Your_YouTube_Red_revenue_USD => {},
    YouTube_Red_watch_time_hours => {},
    Annotation_clicks => {},
    Clickable_annotations_shown => {},
    Clicks_per_clickable_annotation_shown => {},
    Annotation_closes => {},
    Closable_annotations_shown => {},
    Close_rate => {},
    Annotations_shown => {},
    Likes => {},
    Likes_added => {},
    Likes_removed => {},
    Dislikes => {},
    Dislikes_added => {},
    Dislikes_removed => {},
    Shares => {},
    Comments => {},
    Videos_in_playlists => {},
    Videos_added_to_playlists => {},
    Videos_removed_from_playlists => {},
    Subscribers => { data_type => 'Int', is_numeric => 1 },
    Subscribers_gained => { data_type => 'Int', is_numeric => 1 },
    Subscribers_lost => { data_type => 'Int', is_numeric => 1 },
    Game_ID => {
	data_type => 'Int',
	is_numeric => 1,
    },
    );

__PACKAGE__->set_primary_key("Video_ID");

## relationships
__PACKAGE__->belongs_to(
    game => "YouTube::Analytics::Schema::Result::Games",
    'Game_ID',
    );

1;
