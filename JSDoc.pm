package JSDoc;
# Reads JSDoc from js files.

use strict;
use warnings;

use FileReader;

sub init {
    print "Hello, this is JSDoc. \n";
    print "File to read: ";

    my $input_file = <STDIN>;
    chomp( $input_file );
    #DEBUG - TODO
    $input_file = 'maze.js' unless $input_file;
    #return unless $input_file;
    #DEBUG - TODO

    my $file_reader = FileReader->new( file_name => $input_file );
    return unless $file_reader;

    my @file_contents = $file_reader->read_file();
    print_doc( @file_contents );

    print "Thank you, come again. \n";
}

sub print_doc {
    my @file_contents = @_;
    return unless @file_contents;

    my @docs = find_docs( @file_contents );
    print "\n*** PRINTING DOCS ***\n";

    @docs = parse_docs( @docs );
    foreach ( @docs ) {
        print $_, " -------------------------------------------------- \n";
    }
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

init();

1;
