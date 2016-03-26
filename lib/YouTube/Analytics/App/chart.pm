package YouTube::Analytics::App::chart;
use warnings;
use strict;

use MooseX::App::Command;
extends 'YouTube::Analytics::App';

use YouTube::Analytics::Charts;

option 'report_path' => (
    is => 'rw',
    isa => 'Str',
    default => '/tmp',
    );

option 'all' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
    documentation => 'Print all reports',
    );

option 'views' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
    );

option 'subscribers' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
    );

option 'likes' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
    );

option 'duration' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
    );

option 'comments' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
    );

sub run {
    my $self = shift;

    my $charts = YouTube::Analytics::Charts->new(
	schema => $self->_schema,
	report_path => $self->report_path,
	);

    if ($self->views or $self->all) {
	$charts->average_views_per_game('yta-views', 'png');
    }

    if ($self->subscribers or $self->all) {
	$charts->subscriber_change_per_game('yta-subs', 'png');
    }

    if ($self->likes or $self->all) {
	$charts->likes_per_game('yta-likes', 'png');
    }

    if ($self->duration or $self->all) {
	$charts->average_durarion_per_game('yta-duration', 'png');
    }

    if ($self->comments or $self->all) {
	$charts->average_comments_per_game('yta-comments', 'png');
    }
}

1;
