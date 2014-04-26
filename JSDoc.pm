package JSDoc;
# Reads JSDoc from js files.

use strict;
use warnings;

use FileReader;

sub init {
    print "Hello, this is JSDoc. \n";
    print "File to read: ";

    my $input_file;
    $input_file = <STDIN>;
    chomp( $input_file );
    #DEBUG - TODO
    $input_file = 'maze.js';
    #DEBUG - TODO
    return unless $input_file;

    my $file = FileReader->new( file_name => $input_file );
    return unless $file;

    $file->print_doc();

    print "Thank you, come again. \n";
}

init();

1;
