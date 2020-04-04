#!/usr/bin/env sh
#
# Creates a fitting lockscreen image for i3locks.
#
# $1: path to a image to use
# $2: name of new lockscreen
#
# Creates a black background the size of the combined screen size of all your
#   monitors and takes the image and puts it where your primary display is.

total_size=$(xrandr | grep -E -o "current [0-9]+ x [0-9]+" | sed 's/current\ //g; s/\ //g')

primary_x=$(xrandr | grep -E -o "primary [0-9]+x[0-9]+\+[0-9]+\+[0-9]+" | sed 's/primary\ //' | cut -d '+' -f 2)
primary_y=$(xrandr | grep -E -o "primary [0-9]+x[0-9]+\+[0-9]+\+[0-9]+" | sed 's/primary\ //' | cut -d '+' -f 3)

convert -size "$total_size" xc:black "$1" -geometry +"$primary_x"+"$primary_y" -composite -matte "$2"
