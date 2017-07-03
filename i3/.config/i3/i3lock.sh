#!/bin/bash

# Check if already locked
if [[  $(pgrep -cx i3lock) -gt 0 ]] ; then
  printf "%s\n" "i3lock is already running." >&2
  exit 1
fi

# FIXME: The hackiest hack, make sure we escape VMWare Workstation as locking
# seems to fail otherwise!!!
xdotool keydown ctrl+alt; xdotool keyup ctrl+alt

# Lock screen displaying this image.
i3lock --color "#151515"

# Turn the screen off after a delay.
(sleep 60; pgrep i3lock && xset dpms force off) &
