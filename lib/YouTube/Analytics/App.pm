package YouTube::Analytics::App;
use warnings;
use strict;

use MooseX::App qw(Color ConfigHome Version);

use YouTube::Analytics::Schema;

our $VERSION = '0.01';

option 'db' => (
    is  => 'rw',
    isa => 'Str',
    required => 1,
    documentation => 'Path to SQLite3 database',
    );

sub _dsn {
    my $self = shift;

    # Only support SQLite for now
    my $dsn = 'dbi:SQLite:'.$self->db;

    return $dsn;
}

sub _schema {
    my $self = shift;

    return YouTube::Analytics::Schema->connect($self->_dsn); 
}

1;
