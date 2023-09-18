#!/bin/sh

LAPTOP_DISPLAY=`xrandr --query | grep "eDP" | awk '{print $1}'`

xrandr --output eDP-1 --primary --mode 1366x768 --pos 0x360 --rotate normal --output HDMI-1 --mode 3840x2160 --pos 1366x0 --rotate normal --output DP-1 --off --output DP-2 --off
