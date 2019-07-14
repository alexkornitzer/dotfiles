[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -d $HOME/.xkb ]] && xkbcomp -I$HOME/.xkb -R$HOME/.xkb keymap/custom $DISPLAY
xrandr --dpi 192
xhost +local:
exec bspwm
