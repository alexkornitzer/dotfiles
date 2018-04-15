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
revert() {
  xset dpms 0 0 0
}
trap revert HUP INT TERM
xset +dpms dpms 5 5 5
if [[ `i3lock --version 2>&1 | cut -d" " -f3` = *c ]]; then
  i3lock -n --color "#151515" --insidecolor "#151515FF" --ringcolor "#262626FF" --ringvercolor "#0d61acFF" --insidevercolor "#151515FF" --ringwrongcolor "#870000FF" --insidewrongcolor "#151515FF" --keyhlcolor "#262626FF" --bshlcolor "#870000FF" --verifcolor "#fefefeFF" --wrongcolor "#fefefeFF" --linecolor "#fefefeff" --separatorcolor "#fefefeff" --wrongtext "failed" --veriftext "checking" -S 1
else
  i3lock -n --color "#151515"
fi
revert
