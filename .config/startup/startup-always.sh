#!/bin/bash

# Polybar
~/.config/polybar/launch.sh &

# System
docker &
xset -b &
# xsettingsd & # Used to scale GTK apps when going 2K <=> 4K
xfce4-power-manager &

# Apps
1password --silent &
$HOME/scripts/exterminate nm-applet; nm-applet &
$HOME/scripts/exterminate blueberry; blueberry &
$HOME/scripts/exterminate copyq; copyq &
$HOME/scripts/exterminate fusuma; fusuma &
$HOME/scripts/exterminate flameshot; flameshot &
$HOME/scripts/exterminate sxhkd; mkfifo /tmp/sxhkd.fifo || true; sxhkd -t 10 -s /tmp/sxhkd.fifo &