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
  locker='~/.i3/i3lock.sh'
  xautolock -time 1 -notify 5 -notifier "notify-send 'Locking'" -corners 0-00 -locker $locker &
fi

# Start RedShift GTK
if [[  $(pgrep -cx redshift-gtk) -eq 0 ]] ; then
  redshift-gtk &
fi
