#!/bin/bash
#
# Executions that need some if statements!
#

# Exit if a we are a virtual machine
if [[  $(lsmod | grep ^vmwgfx | wc -l) -gt 0 ]] ; then
  vmware-user-suid-wrapper &
  exit
fi

# Start autolock
if [[  $(pgrep -cx xautolock) -eq 0 ]] ; then
  locker="$HOME/.config/i3/i3lock.sh"
  xautolock -time 1 -detectsleep -notify 5 -notifier "notify-send 'Locking'" -corners -000 -locker $locker &
fi

# Start xss-lock
if [[  $(pgrep -cx xss-lock) -eq 0 ]] ; then
  locker="$HOME/.config/i3/i3lock.sh"
  xss-lock -- $locker -f &
fi

# Start RedShift GTK
if [[  $(pgrep -cx redshift-gtk) -eq 0 ]] ; then
  redshift-gtk &
fi
