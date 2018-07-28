# TODO: Only set the laptop screen
xrandr --dpi 192 2>/dev/null

[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources
[[ -f $HOME/.Xmodmap ]] && xmodmap $HOME/.Xmodmap

# TODO: Work out who called us
#exec i3 -dV > /tmp/i3.log
#exec i3
