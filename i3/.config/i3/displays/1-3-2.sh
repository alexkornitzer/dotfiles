#!/bin/sh
xrandr --output eDP-1 --primary --auto --pos 0x0 --rotate normal --output DP-1 --auto --right-of DP-2 --rotate normal --output HDMI-2 --off --output HDMI-1 --off --output DP-2 --auto --right-of eDP-1 --rotate normal
i3-msg "workspace number 1"
i3-msg "move workspace to output eDP-1"
i3-msg "workspace number 2"
i3-msg "move workspace to output DP-2"
i3-msg "workspace number 3"
i3-msg "move workspace to output DP-1"
i3-msg "workspace number 1"
