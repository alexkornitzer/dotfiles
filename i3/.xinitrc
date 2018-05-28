# TODO: Only set the laptop screen
xrandr --dpi 192 2>/dev/null

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# TODO: Work out who called us
#exec i3
