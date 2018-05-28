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
xrandr --output $EDP1 --primary --auto --pos 0x0 --rotate normal \
       --output $DP1 --off \
       --output $DP2 --off \
       --output $HDMI1 --off \
       --output $HDMI2 --off
