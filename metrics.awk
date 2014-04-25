#!/bin/awk -f
# $Id: metrics.awk,v 1.4 2004/03/30 01:53:13 mimorgan Exp $
# Simple script to count number of code lines and number of comment lines.
# Attempts to count both C++ and C comments intelligently.
# Displays totals and ratio of comments to total lines.

BEGIN {
    c_comments   = 0;
    cpp_comments = 0;
    lines        = 0;
    in_c_comment = 0;
}

{
    in_cpp_comment = 0;
}

# C++ comment line
/^[ \t]*\/\// {
    cpp_comments++;
    in_cpp_comment = 1;
}


# C begin comment
/\/\*/ {
    if(!in_cpp_comment)
    {
	if(in_c_comment)
	{
	    printf("HELP! Beginning nested comment: file %s\n", FILENAME);
	}
	else
	{
	    in_c_comment = 1;
	}
    }
}

# C end comment
/\*\// {
    if(!in_cpp_comment)
    {
	if(in_c_comment)
	{
	    c_comments++;
	    in_c_comment = 0;
	}
	else
	{
	    printf("HELP! Ending a comment not begun: file %s\n", FILENAME);
	}
    }
}


{
    if(in_c_comment)
	c_comments++;

    if(NF > 0)
	lines++;
}


END {
    totalcom = c_comments + cpp_comments;
    printf("Total lines         = %d\n", lines);
    printf("Total comment lines = %d\n", totalcom);
    if (lines) {
	printf("Comments to lines   = %%%.1f\n", 100.0*totalcom/lines);
    }
}

