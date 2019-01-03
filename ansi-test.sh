#!/bin/bash
# Testing ANSI escape sequences in the terminal.
#
# Terminal settings seem to be
# Escape Character: '' (C-Q, C-[ in emacs) is the raw escape character.
# Some shells have echo -e. If so can use: '\e'
# Other shells don't recognize \e. If so can use the escape value: '\033'
#
# End of colorizing escape: m
# Separator for colors: ;
#
# xterm's have other sequences, used to set window title and whatnot.
# See prompt_basic and family in bash/functions.
#
# For more info see:
# http://en.wikipedia.org/wiki/ANSI_escape_code

# esc="\033"
esc="\e"

######################################################################
# ANSI color:
#
# Styles:
# ;1 -> bold
# ;2 -> faded
# ;3 -> italic
# ;4 -> underline
# ;5 -> blink
# ;6 -> (nothing?)
# ;7 -> inverse

echo "****** ANSI colors and modifiers ******"
# echo "Base colors (30-37):"
for color in {30..37}
do {
  echo -ne "${esc}[${color}mcolor ${color}${esc}[0m "
  for style in {1,2,3,4,7}
  do {
    echo -ne "${esc}[${color};${style}mcolor ${color};${style}${esc}[0m "
  }
  done
  echo
}
done

# echo "Bright colors (90-97):"
for color in {90..97}
do {
  echo -ne "${esc}[${color}mcolor ${color}${esc}[0m "
  # 5 is blink, 6 is nothing?
  for style in {1,2,3,4,7}
  do {
    echo -ne "${esc}[${color};${style}mcolor ${color};${style}${esc}[0m "
  }
  done
  echo
}
done

# echo "Background colors (40-47):"
for bkg in {40..47}
do {
  echo -ne "${esc}[37;${bkg}mcolor 37;${bkg}${esc}[0m "
  for style in {1,2,3,4,7}
  do {
    echo -ne "${esc}[37;${bkg};${style}mcolor 37;${bkg};${style}${esc}[0m "
  }
  done
  echo
}
done

# echo "Bright Background colors (100-107):"
for bkg in {100..107}
do {
  echo -ne "${esc}[37;${bkg}mcolor 37;${bkg}${esc}[0m "
  for style in {1,2,3,4,7}
  do {
    echo -ne "${esc}[37;${bkg};${style}mcolor 37;${bkg};${style}${esc}[0m "
  }
  done
  echo
}
done

# Just in case we mucked things up
echo -ne "${esc}[0m"

######################################################################
# 8-bit color method:
#
# As 256-color lookup tables became common on graphic cards, escape sequences
# were added to select from a pre-defined set of 256 colors:
#
#    ESC[ 38;5;<n> m Select foreground color
#    ESC[ 48;5;<n> m Select background color
#      0-  7:  standard colors (as in ESC [ 30–37 m)
#      8- 15:  high intensity colors (as in ESC [ 90–97 m)
#     16-231:  6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
#    232-255:  grayscale from black to white in 24 steps
######################################################################

# 8 basic colors, 8 bright/intense versions
echo "****** 8-bit colors ******"
numcolors=8
for intensity in {0,1}
do {
  for color in {0..7}
  do {
    ((shownum=$numcolors * ${intensity} + $color))
    echo -en "${esc}[0;48;5;${shownum}m color ${shownum} ${esc}[0m"
  }
  done
  echo
}
done

# Note: Much angst goes into the orderiung of these :)
# Yes the numbers are "out of reading order" when printed, but the
# red / blue / green and green / blue / red loop nestings both make
# the color "cube" more smooth and apparent.
# red / green / blue nesting puts numbers in L to R top to bottom order.
redoffset=36
greenoffset=6
cubestart=16
for green in {0..5}
do {
  for blue in {0..5}
  do {
    for red in {0..5}
    do {
      ((bg=$cubestart + $redoffset * $red + $greenoffset * $green + $blue))
      # Invert the text against the background: looks a bit wonky
      # ((textcolor=247-$bg))

      # Make an estimate of intensity for the foreground?
      textcolor=0
      if ((($green + $red) < 4)) ; then
        textcolor=15
      fi
      echo -en "${esc}[48;5;${bg}m${esc}[38;5;${textcolor}m color ${bg} ${esc}[0m"
    }
    done
    echo
  }
  done
}
done

# 24 steps of greyscale
bwoffset=232
for grey in {0..23}
do {
   ((bg=$bwoffset + $grey))
   echo -en "${esc}[0;48;5;${bg}m ${bg}${esc}[0m"
}
done

echo

# Just in case we mucked things up
echo -ne "${esc}[0m"

######################################################################
# TODO:
# 24-bit
#
# As "true color" graphic cards with 16 to 24 bits of color became common,
# Xterm,[19] KDE's Konsole,[26] as well as all libvte based terminals[27]
# (including GNOME Terminal) support 24-bit foreground and background color
# setting,
#
#    ESC[ 38;2;<r>;<g>;<b> m Select RGB foreground color
#    ESC[ 48;2;<r>;<g>;<b> m Select RGB background color

echo "****** 24-bit colors under construction ******"

echo -en "${esc}[38;2;50m${esc}[48;2;24;24;24;m color 64.0.0 ${esc}[0m"
echo -en "${esc}[48;2;64;0;0m${esc}[38;2;0;0;0m color 64.0.0 ${esc}[0m"
echo -en "${esc}[48;2;0;64;0m${esc}[38;2;0;0;0m color 0.64.0 ${esc}[0m"
echo -en "${esc}[48;2;0;0;64m${esc}[38;2;0;0;0m color 0.0.64 ${esc}[0m"
echo -en "${esc}[48;2;100;100;100m${esc}[38;2;0;0;0m color 100.100.100 ${esc}[0m"
echo
