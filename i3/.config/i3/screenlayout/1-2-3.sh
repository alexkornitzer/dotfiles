#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --primary --auto --pos 0x0 --rotate normal --output DP1 --auto --right-of eDP1 --rotate normal --output HDMI2 --off --output HDMI1 --off --output DP2 --auto --right-of DP1 --rotate normal
i3-msg "workspace number 1"
i3-msg "move workspace to output eDP1"
i3-msg "workspace number 2"
i3-msg "move workspace to output DP1"
i3-msg "workspace number 3"
i3-msg "move workspace to output DP2"
i3-msg "workspace number 1"
