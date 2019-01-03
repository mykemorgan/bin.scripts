#!/usr/bin/awk -f
# $Id: find_func.awk,v 1.1 2001/03/22 00:13:06 myke Exp $
# Find and disply all function calls, even those spanning multiple lines.
# Fixup the output so there is one call per line in the output.
#

BEGIN {
    search_pat = ARGV[1];
    for(i=2 ; i<ARGC ; i++) {
	ARGV[i-1] = ARGV[i];
    }
    ARGC--;
}


{
    if(match($0, search_pat)) {
	print_entire_func();
    }
}

function print_entire_func() {
    printf("%s:%d ", FILENAME, FNR);

    line = "";
    while(1) {
	# Eat whitespace
	gsub("^[ \t]*", "", $0);
	line = sprintf("%s%s", line, $0);

	if(match($0, "\);")) {
	    infunc = 0;
	    break;
	}
	getline;
    }

    # Cat strings together.
    gsub("\"\"", "", line);
    printf("%s\n", line);
}

END {

}
