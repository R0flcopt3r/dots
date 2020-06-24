#!/usr/bin/env sh

mic=$(amixer get Capture | grep "Front Left: Capture" | awk '{print $6}')

red="#EF2F27"

if [ "$mic" = "[on]" ]
then
	echo ' '
else
	echo '%{u'"$red"'} %{u-}'
fi
