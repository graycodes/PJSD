package FileReader;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {@_};
    bless($self, $class);
    return $self;
}

sub read_file {
    my $self = shift;
    my $file_name = $self->{file_name};
    return unless $self->{file_name};

    open(my $file_handle, '<', $file_name)
        or die "Unable to open file: $!...\n";

    return <$file_handle>;# file contents
}

1;
