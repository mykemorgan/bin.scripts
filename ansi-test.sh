#!/bin/bash
# Testing ANSI escape sequences in the terminal.
#
# Mac terminal settings seem to be 
# Escape Sequence: [ "C-Q, C-[ in emacs, I think the escape character"
# End of escape: m
# Separator: ;
#
# xterm's have other sequences, used to set window title and whatnot.
# See prompt_ucm and family in .bash/functions.
#
# More info see:
# http://en.wikipedia.org/wiki/ANSI_escape_code

echo "Normal first [30mthen color 30[0m then back to normal"
echo "Normal first [31mthen color 31[0m then back to normal"
echo "Normal first [32mthen color 32[0m then back to normal"
echo "Normal first [33mthen color 33[0m then back to normal"
echo "Normal first [34mthen color 34[0m then back to normal"
echo "Normal first [35mthen color 35[0m then back to normal"
echo "Normal first [36mthen color 36[0m then back to normal"
echo "Normal first [37mthen color 37[0m then back to normal"
echo "Normal first [30;1mthen color 30;1[0m then back to normal"
echo "Normal first [31;1mthen color 31;1[0m then back to normal"
echo "Normal first [32;1mthen color 32;1[0m then back to normal"
echo "Normal first [33;1mthen color 33;1[0m then back to normal"
echo "Normal first [34;1mthen color 34;1[0m then back to normal"
echo "Normal first [35;1mthen color 35;1[0m then back to normal"
echo "Normal first [36;1mthen color 36;1[0m then back to normal"
echo "Normal first [37;1mthen color 37;1[0m then back to normal"
echo "Normal first [37;40mthen color 37;40[0m then back to normal"
echo "Normal first [37;41mthen color 37;41[0m then back to normal"
echo "Normal first [37;42mthen color 37;42[0m then back to normal"
echo "Normal first [37;43mthen color 37;43[0m then back to normal"
echo "Normal first [37;44mthen color 37;44[0m then back to normal"
echo "Normal first [37;45mthen color 37;45[0m then back to normal"
echo "Normal first [37;46mthen color 37;46[0m then back to normal"
echo "Normal first [37;47mthen color 37;46[0m then back to normal"
echo "Normal first [37;40;1mthen color 37;40;1[0m then back to normal"
echo "Normal first [37;41;1mthen color 37;41;1[0m then back to normal"
echo "Normal first [37;42;1mthen color 37;42;1[0m then back to normal"
echo "Normal first [37;43;1mthen color 37;43;1[0m then back to normal"
echo "Normal first [37;44;1mthen color 37;44;1[0m then back to normal"
echo "Normal first [37;45;1mthen color 37;45;1[0m then back to normal"
echo "Normal first [37;46;1mthen color 37;46;1[0m then back to normal"
echo "Normal first [37;47;1mthen color 37;47;1[0m then back to normal"
