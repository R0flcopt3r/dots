#!/bin/sh
xrandr\
    --output eDP-1-1 --off\
    --output DP-1-1 --off\
    --output HDMI-1-1 --off\
    --output DP-1-2 --off\
    --output HDMI-1-2 --off\
    --output DP-1-3 --off\
    --output HDMI-1-3 --off\
    --output DP-1-3-1 --off\
    --output DP-1-3-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal\
    --output DP-1-3-3 --off

bspc monitor DP-1-3-2 -d "1-www" "2-com" "3-cli" "4-cli" 5 6 "7-daw" "8-game" 9 10
