#!/bin/sh
# User input in the shell examples.

# Let user pick one of N predetermined items.
PS3="Select an item>> "
select foo in `echo ItemOne ItemTwo ItemThree Quit` ;
do
    if [ ".$foo" != "." ] ;
    then
	echo "Selected \"$foo\""
	if [ "$foo" = "Quit" ] ;
	then
	    echo "Quitting..."
	    exit 0
	fi
	break
    fi
done

echo ""

# Simple wait for keypress and act on key (continue/quit)
echo "Sorry to ask again, but..."
read -s -n 1 -p "Press Any Key to Continue, or 'q' to quit>>  " answer

if [ "$answer" = "q" ] ;
then
    echo ""
    echo "Quitter."
    exit 0
else
    echo ""
    echo "Continuing..."
fi

i=0
while ((i<3)) ;
do
    echo "Doing some stuff #$i..."
    ((i++))
    sleep 1
done

exit 0
