#!/usr/bin/python
# $Id: find_code.py,v 1.2 2007/09/27 19:05:02 mimorgan Exp $
# Tool to search all the code in the world *under* the current directory

import os
import sys
import getopt

def search_patterns(pattern) :

    dirs_to_ignore = [ ".", "./pexml", "./gsoap", ".gsoap2", "./gsoap2_3_8", "./unittest", "./stf" ]
    
    if (verbose) :
        print "Searching for pattern '%s'" % (pattern)

    # Search in current dir first.
    # Need to make this file list the same as in the find command below...
    # Alternatively, just need to find from the top level directory? Why did I do it this way?
    dir_files_cmd = "ls *akefile *.cpp *.h *.c *.java *.py 2> /dev/null"
    search_using_file_filter(dir_files_cmd, pattern)

    # Completely search any top-level subdirectories next
    # Use maxdepth because the file find command itself traverses subdirs
    find_dirs_cmd = "find . -maxdepth 1 -type l -o -type d"
    dirs_fd = os.popen(find_dirs_cmd)
    for currdir in dirs_fd.readlines():
        currdir = currdir.rstrip('\n')
        if (verbose >= 3) :
            print "Found dir '%s'" % (currdir)

        # If no subdirectories here, we're not searching anything...
        if currdir in dirs_to_ignore :
            continue
        
        if (verbose >= 1) :
            print "Searching top-level directory '%s'" % (currdir)

        find_files_cmd = "find " + \
                         currdir + "/ " \
                         "\( -name '*akefile' -o -name '*.cpp' -o -name '*.h' -o -name '*.c'  -o -name '*.java' -o -name '*.py' \)"
        search_using_file_filter(find_files_cmd, pattern)

    return

# Run the given 'cmd' and assume it will spit out file names, one per line,
# in which to grep for our pattern.
def search_using_file_filter(find_files_cmd, pattern):
    if (verbose >= 2) :
        print "Searching for files using cmd '%s'" % (find_files_cmd)

    files_fd = os.popen(find_files_cmd)

    for currfile in files_fd.readlines():
        currfile = currfile.rstrip('\n')
        # Maybe don't use '-H' and print out the filename ourselves.
        grep_cmd = "grep '" + \
                   pattern + "' " + \
                   currfile
        if (verbose >= 2) :
            print "Searching file using command '%s'" % (grep_cmd)

        results_fd = os.popen(grep_cmd)
        for currresult in results_fd.readlines():
            currresult = currresult.rstrip('\n')
            # Colorize the output - Doesn't work with regex's
            currresult = currresult.replace(pattern, "[31m" + pattern + "[0m")
            print "%s: %s" % (currfile, currresult)

    return

def usage(argv0) :
    print "Usage: %s OPTION <search pattern>" % (argv0)
    print "       -?, --help          Show this help message."
    print "       -v --verbose         Increase verbose level. Up to three can be specified."
    

# start of main
if (__name__ == '__main__'):

    verbose = 0
    
    try:
        opts, args = getopt.getopt(sys.argv[1:], "?v", ["help", "verbose"])
    except getopt.GetoptError:
        # print help information and exit:
        usage(sys.argv[0])
        sys.exit(2)

    for o, a in opts:
        if o in ("-v", "--verbose"):
            verbose = verbose + 1
        elif o in ("-?", "--help"):
            usage(sys.argv[0])
            sys.exit()

#    print args
    
    if (len(args) > 0) :
#        a=0
#        pattern=""
#        while a<len(args) :
#            pattern += args[a]
#            pattern += " "
#            a += 1
#        print pattern
#        search_patterns(pattern)
        search_patterns(args[0])
    else :
        usage(sys.argv[0])
    
    
    
