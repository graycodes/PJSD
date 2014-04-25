package FileReader;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {@_};
    bless($self, $class);
    return $self;
}

sub print_doc {
    my $self = shift;
    return unless $self->{file_name};
    print $self->{file_name};

    my @file_contents = read_file($self->{file_name});
    return unless @file_contents;

    my @docs = find_docs( @file_contents );
    print "PRINTING DOCS";
    print @docs;
}

sub read_file {
    my $file_name = shift;
    return unless $file_name;

    open(my $file_handle, '<', $file_name)
        or die "Unable to open file: $!...\n";

    return <$file_handle>;
}

sub find_docs {
    my @contents = @_;

#    while ($contents) {
#        print $_;
#    }
}

1;
