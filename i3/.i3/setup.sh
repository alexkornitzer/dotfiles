#!/bin/bash

# Very basic script to ensure that dependencies are installed
sudo apt-get install i3 i3lock i3blocks arc-theme compton dunst fonts-dejavu \
  fonts-font-awesome moka-icon-theme rofi thunar udiskie xfce4-terminal

# FIXME: Don't use TLP in a VM!!!
if ! [[ "$(lsmod | grep vmwgfx)" ]]; then
  sudo apt-get install redshift-gtk tlp
fi
