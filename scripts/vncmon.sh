#!/bin/bash

xrandr --output VIRTUAL1 --mode 1440x1080_60.00 --right-of eDP1
x11vnc -clip 1440x1080+1920+0 -usepw && xrandr --output VIRTUAL1 --off 
