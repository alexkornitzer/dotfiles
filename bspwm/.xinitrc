#!/usr/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -d $HOME/.xkb ]] && xkbcomp -I$HOME/.xkb -R$HOME/.xkb keymap/custom $DISPLAY
xrandr --dpi 192

list=( $(ls -1 /home/alex/.66/conf/svscan@alex) )
for i in ${list[@]};do
    var=$(</home/alex/.66/conf/svscan@alex/${i})
    for j in ${var[@]}; do
		export ${j}
    done
done

66-all up

## Try consolekit
if 66-which -q ck-launch-session; then
	cmd="exec ck-launch-session $@"
else
	cmd="exec $@"
fi

## Select the session to start
${cmd} bspwm
