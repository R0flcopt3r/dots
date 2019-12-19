#!/bin/bash
#
# select-display
#

choices=("presentation" "home" "laptop" "manual")
chosen=$(printf "%s\n" "${choices[@]}" \
		| rofi -dmenu -no-custom -l "${#choices[@]}" -p "display")

case "$chosen" in
    ${choices[1]})  "$HOME"/.screenlayout/presentation.sh
		;;
	${choices[2]})  "$HOME"/.screenlayout/Docking-Gjøvik.sh
		;;
	${choices[3]})  "$HOME"/.screenlayout/default.sh
		;;
    ${choices[4]})   arandr
		;;
esac
