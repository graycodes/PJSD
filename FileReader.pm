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

    my @file_contents = read_file($self->{file_name});
    return unless @file_contents;

    my @docs = find_docs( @file_contents );
    print "\n*** PRINTING DOCS ***\n";

    @docs = parse_docs( @docs );
    foreach ( @docs ) {
        print $_, " -------------------------------------------------- \n";
    }
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
    my @docs;
    my $doc = '';
    my $in_doc = 0;
    my $push = 0;
    my $start = 0;
    my $end = 0;
    my $next_line = 0;

    foreach (@contents) {
        $start = _is_doc_start( $_ );
        $end   = _is_doc_end( $_ );

        if ( !$start && !$end && !$in_doc && !$next_line ) {
            next;
        }

        $in_doc = 1 if $start;
        $in_doc = 0 if $end;

        $doc .= $_;

        if ( $next_line ) {
            push( @docs, $doc );
            $doc = '';
            $next_line = 0;
        }

        next unless $end;
        $next_line = 1;

    }

    return @docs;
}

sub parse_docs {
    my @docs = @_;
    my @output;

    @output = map { (my $s = $_) =~ s/^ *(\*\/|\/\*\*|\*)//gm; $s } @docs;

    return @output;
}

sub _is_doc_start {
    my $line = shift;
    return $line =~ /\/\*\*/;
}

sub _is_doc_end {
    my $line = shift;
    return $line =~ /\*\//;
}

1;
