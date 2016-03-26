package YouTube::Analytics::Charts;
use warnings;
use strict;
use Moose;

#use Chart::Gnuplot;
use GD::Graph::bars;
use YouTube::Analytics::Schema;

# YouTube::Analytics::Schema
has 'schema' => (
    is  => 'rw',
    isa => 'YouTube::Analytics::Schema',
    required => 1,
    );

has 'report_path' => (
    is => 'rw',
    required => 1,
    documentation => 'Path to a directory where reports are written',
    default => '/tmp',
    );

has 'height' => (
    is => 'rw',
    isa => 'Int',
    required => 1,
    documentation => 'Chart height (pixels)',
    default => 700,
    );

has 'width' => (
    is => 'rw',
    isa => 'Int',
    required => 1,
    documentation => 'Chart width (pixels)',
    default => 600,
    );

# $file - File name without extension
# $type - Output type supported by GD::Graph. Default: png
# $width - pixels. Default: 600
# $height - pixels. Default: 700
sub average_views_per_game {
    my $self = shift;
    my $file = shift;
    my $type = shift || 'png';
    my $width = shift || $self->width;
    my $height = shift || $self->height;

    my $averages = $self->_column_average('Views', 'Watch_time_minutes');

    my @data = ($averages->{'_labels'},
		$averages->{'Views'},
		$averages->{'Watch_time_minutes'}
	);	
    my $graph = GD::Graph::bars->new($width,$height);
    $graph->set(
	y1_label => 'Views / video',
	y2_label => 'Watch minutes / video',
	title   => 'Average views per game video',
	two_axes => 1,
	x_labels_vertical => 1,
	transparent => 0,
	b_margin => 5,
	);
    my $gd = $graph->plot(\@data)
	or die $graph->error;

    $self->_write_chart($gd, $file, $type);

    # my $dataset = Chart::Gnuplot::DataSet->new(
    # 	style => 'histograms',
    # 	# style => 'boxes',
    # 	xdata => undef,
    # 	ydata => \@averages,
    # 	);
    
    # my $chart = Chart::Gnuplot->new(
    # 	output => $self->report_path.'/'.$file,
    # 	title => "Average views per game",
    # 	ylabel => 'Views',
    # 	bg => 'white',
    # 	# xtics => {
    # 	#     labels => [ map { "\"$_\"" } @labels ],
    # 	#     labelfmt => '%s',
    # 	#     rotate => '90',
    # 	# },
    # 	);

    # $chart->plot2d($dataset);
}

# $file - File name without extension
# $type - Output type supported by GD::Graph. Default: png
# $width - pixels. Default: 600
# $height - pixels. Default: 700
sub subscriber_change_per_game {
    my $self = shift;
    my $file = shift;
    my $type = shift || 'png';
    my $width = shift || 600;
    my $height = shift || 700;

    my $averages = $self->_column_sum(
	'Subscribers_gained', 'Subscribers_lost'
	);

    my @data = ($averages->{'_labels'},
		$averages->{'Subscribers_gained'},
		$averages->{'Subscribers_lost'}
	);	
    my $graph = GD::Graph::bars->new($width,$height);
    $graph->set(
	y1_label => 'Subscribers gained',
	y2_label => 'Subscribers lost',
	title   => 'Change in subscribers per game',
	two_axes => 1,
	x_labels_vertical => 1,
	transparent => 0,
	b_margin => 5,
	);
    my $gd = $graph->plot(\@data)
	or die $graph->error;

    $self->_write_chart($gd, $file, $type);

}

# $file - File name without extension
# $type - Output type supported by GD::Graph. Default: png
# $width - pixels. Default: 600
# $height - pixels. Default: 700
sub likes_per_game {
    my $self = shift;
    my $file = shift;
    my $type = shift || 'png';
    my $width = shift || 600;
    my $height = shift || 700;

    my $averages = $self->_column_sum(
	'Likes', 'Dislikes'
	);

    my @data = ($averages->{'_labels'},
		$averages->{'Likes'},
		$averages->{'Dislikes'}
	);	
    my $graph = GD::Graph::bars->new($width,$height);
    $graph->set(
	y_label  => 'Likes / Dislikes',
	#y1_label => 'Likes',
	#y2_label => 'Dislikes',
	title   => 'Likes and Dislikes per game',
	#two_axes => 1,
	x_labels_vertical => 1,
	transparent => 0,
	b_margin => 5,
	);
    my $gd = $graph->plot(\@data)
	or die $graph->error;

    $self->_write_chart($gd, $file, $type);

}

# $file - File name without extension
# $type - Output type supported by GD::Graph. Default: png
# $width - pixels. Default: 600
# $height - pixels. Default: 700
sub average_durarion_per_game {
    my $self = shift;
    my $file = shift;
    my $type = shift || 'png';
    my $width = shift || 600;
    my $height = shift || 700;

    my $averages = $self->_column_average('Views', 'Average_view_duration_minutes');

    my @data = ($averages->{'_labels'},
		$averages->{'Views'},
		$averages->{'Average_view_duration_minutes'}
	);	
    my $graph = GD::Graph::bars->new($width,$height);
    $graph->set(
	y1_label => 'Views / video',
	y2_label => 'Average view duration minutes / video',
	title   => 'Average view duration per game video',
	two_axes => 1,
	x_labels_vertical => 1,
	transparent => 0,
	b_margin => 5,
	);
    my $gd = $graph->plot(\@data)
	or die $graph->error;

    $self->_write_chart($gd, $file, $type);

}

# $file - File name without extension
# $type - Output type supported by GD::Graph. Default: png
# $width - pixels. Default: 600
# $height - pixels. Default: 700
sub average_comments_per_game {
    my $self = shift;
    my $file = shift;
    my $type = shift || 'png';
    my $width = shift || 600;
    my $height = shift || 700;

    my $averages = $self->_column_average('Average_view_duration_minutes', 'Comments');

    my @data = ($averages->{'_labels'},
		$averages->{'Average_view_duration_minutes'},
		$averages->{'Comments'}
	);	
    my $graph = GD::Graph::bars->new($width,$height);
    $graph->set(
	y1_label => 'Average view duration minutes / video',
	y2_label => 'Average comments / video',
	title   => 'Average comments per game video',
	two_axes => 1,
	x_labels_vertical => 1,
	transparent => 0,
	b_margin => 5,
	);
    my $gd = $graph->plot(\@data)
	or die $graph->error;

    $self->_write_chart($gd, $file, $type);
}

# _column_average - Get the mean of given columns
#
# returns hash ref
#  _labels [] = list of game titles
#  column_name [] = The average for each title
#
# The column lists are in the same order as the labels list.
sub _column_average {
    my $self = shift;
    my @columns = @_;

    my $averages = {
	_labels => [],
    };

    my $games = $self->schema->resultset('Games')->search;
    while (my $game = $games->next) {
	push @{ $averages->{_labels} }, $game->Game;
	my $views = $game->views;
	my $count = $views->count;
	foreach my $column (@columns) {
	    if (not defined $averages->{$column}) {
		$averages->{$column} = [];
	    }
	    my $total = $views->get_column($column)->sum;
	    push(
		@{ $averages->{$column} },
		($count == 0 ? 0 : ($total+0.0)/$count)
		);
	}
    }

    return $averages;
}

# _column_sum - Get the sum of given columns
#
# returns hash ref
#  _labels [] = list of game titles
#  column_name [] = The sum for each title
#
# The column lists are in the same order as the labels list.
sub _column_sum {
    my $self = shift;
    my @columns = @_;

    my $averages = {
	_labels => [],
    };

    my $games = $self->schema->resultset('Games')->search;
    while (my $game = $games->next) {
	push @{ $averages->{_labels} }, $game->Game;
	my $views = $game->views;
	my $count = $views->count;
	foreach my $column (@columns) {
	    if (not defined $averages->{$column}) {
		$averages->{$column} = [];
	    }
	    my $total = $views->get_column($column)->sum;
	    # print STDERR $game->Game, " $column $total\n";
	    push(
		@{ $averages->{$column} },
		$total
		);
	}
    }

    return $averages;
}

sub _write_chart {
    my $self = shift;
    my $gd   = shift;
    my $file = shift;
    my $type = shift;

    my $fq_file = $self->report_path.'/'.$file.".$type";
    open my $img, ">$fq_file"
	or die "Unable to open $fq_file: $!";
    binmode $img;
    print $img $gd->$type;
    close $img;

    return;
}

1;
