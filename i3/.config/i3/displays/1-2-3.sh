#!/bin/bash

# Determine naming based on loaded card we can do this super crudely
EDP1='eDP1'
DP1='DP1'
DP2='DP2'
HDMI1='HDMI1'
HDMI2='HDMI2'

DASH_COUNT=`xrandr | sed -n '2p' | cut -d ' ' -f 1 | grep '-' | wc -l`
if [[ $DASH_COUNT -gt 0 ]]; then
  EDP1='eDP'; for i in $(seq 0 $DASH_COUNT); do EDP1=$EDP1 + '-1'; done
  DP1='DP'; for i in $(seq 0 $DASH_COUNT); do DP1=$DP1 + '-1'; done
  DP2='DP'; for i in $(seq 0 $DASH_COUNT); do DP2=$DP2 + '-2'; done
  HDMI1='HDMI'; for i in $(seq 0 $DASH_COUNT); do HDMI1=$HDMI1 + '-1'; done
  HDMI2='HDMI'; for i in $(seq 0 $DASH_COUNT); do HDMI2=$HDMI2 + '-2'; done
fi

# Set layout
DPI=`xdpyinfo | grep -m 1 'dimensions:' | awk '/\d*/ { print $2 }' | cut -d 'x' -f '1'`
if [[ $DPI -ge 192 ]]; then
  xrandr --output $EDP1 --auto \
         --output $DP1 --auto --panning 3840x2400+3840+0 --scale 2x2 --right-of $EDP1 \
         --output $DP2 --auto --panning 3840x2400+3840+0 --scale 2x2 --right-of $DP1 \
         --output $HDMI1 --off \
         --output $HDMI2 --off
else
  xrandr --output $EDP1 --primary --auto --pos 0x0 --rotate normal \
         --output $DP1 --auto --right-of $EDP1 --rotate normal \
         --output $DP2 --auto --right-of $DP1 --rotate normal \
         --output $HDMI1 --off \
         --output $HDMI2 --off
fi

i3-msg "workspace number 1"
i3-msg "move workspace to output $EDP1"
i3-msg "workspace number 2"
i3-msg "move workspace to output $DP1"
i3-msg "workspace number 3"
i3-msg "move workspace to output $DP2"
i3-msg "workspace number 1"
