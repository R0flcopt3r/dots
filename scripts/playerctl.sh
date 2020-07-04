#!/usr/bin/env sh

[ "$1" = "next" ] && shift && playerctl next "$@"
[ "$1" = "prev" ] && shift && playerctl previous "$@"
[ "$1" = "play-pause" ] && shift && playerctl play-pause "$@"

if [ "$(playerctl status)" = "Playing" ]; then
	echo "$(playerctl metadata title "$@")" - "$(playerctl metadata artist "$@")"
else
	playerctl status
fi
