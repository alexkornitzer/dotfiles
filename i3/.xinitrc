# TODO: Only set the laptop screen
xrandr --dpi 192 2>/dev/null

[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources
[[ -d $HOME/.xkb ]] && xkbcomp -I$HOME/.xkb -R$HOME/.xkb keymap/custom $DISPLAY

# TODO: Work out who called us
#exec i3 -dV > /tmp/i3.log
#exec i3
