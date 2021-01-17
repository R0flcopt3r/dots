#!/usr/bin/env sh

[ "$1" = "next" ] && shift && playerctl --player spotify next "$@"
[ "$1" = "prev" ] && shift && playerctl --player spotify previous "$@"
[ "$1" = "play-pause" ] && shift && playerctl --player spotify play-pause "$@"

if [ "$(playerctl --player spotify status)" = "Playing" ]; then
	echo "$(playerctl --player spotify metadata title "$@")" - "$(playerctl --player spotify metadata artist "$@")"
else
	playerctl --player spotify status
fi
