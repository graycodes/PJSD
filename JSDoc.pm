package JSDoc;
# Reads JSDoc from js files.

use strict;
use warnings;

use FileReader;

print "Hello, this is JSDoc. \n";

sub init {
    my $input_file;

    $input_file = <STDIN>;
    chomp( $input_file );
    return unless $input_file;
    print "Input file: $input_file\n";

    my $file = FileReader->new( file_name => $input_file );
    return unless $file;

    $file->print_doc('ararararawr');

    print "Thank you, come again. \n";

}

init();

1;
