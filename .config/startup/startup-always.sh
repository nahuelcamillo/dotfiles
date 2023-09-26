#!/bin/bash

# Polybar
~/.config/polybar/launch.sh &

# System
docker &
xset -b &
xsettingsd & # Used to scale GTK apps when going 2K <=> 4K
xfce4-power-manager &

# Apps
1password --silent &
$HOME/.bin/exterminate nm-applet; nm-applet &
#$HOME/.bin/exterminate blueberry; blueberry &
$HOME/.bin/exterminate copyq; copyq &
$HOME/.bin/exterminate fusuma; fusuma &
$HOME/.bin/exterminate dunst; dunst &
$HOME/.bin/exterminate flameshot; flameshot &
$HOME/.bin/exterminate sxhkd; mkfifo /tmp/sxhkd.fifo || true; sxhkd -t 10 -s /tmp/sxhkd.fifo &