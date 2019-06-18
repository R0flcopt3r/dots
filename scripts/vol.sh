#!/bin/bash

#	Written by R0flcopt3r
#
#	This script is inspired by "volume" a i3blocks script made by the two
#	following: 
#	Julien Bonjean <julien@bonjean.info>
#	Alexander Keller <github@nycroth.com>
#
#	 This program is free software: you can redistribute it and/or modify
#	 it under the terms of the GNU General Public License as published by
#	 the Free Software Foundation, either version 3 of the License, or
#	 (at your option) any later version.
#
#	 This program is distributed in the hope that it will be useful,
#	 but WITHOUT ANY WARRANTY; without even the implied warranty of
#	 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	 GNU General Public License for more details.
#
#	 You should have received a copy of the GNU General Public License
#	 along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#	This program is somwhat smart and is able to adjust whichever scontrol you
#	are playing with. Usage can be seen in the `usage()` function or by 
#	`vol.sh -h` it is made to work with i3blocks as per the last line of code
#	which updates the statusbar.

usage(){
	echo "Usage: $0 -v <dec|inc|toggle> [options]"
	printf "\nOptions:" 
	printf "\n -v <dec|inc|toggle>	volume control, required"
	printf "\n		dec	decrease volume"
	printf "\n		inc	increase volume"
	printf "\n		toggle	toggle mute"
	printf "\n -c [scontrols]	scontrols selector, i.e 'Master'"
	printf "\n -m [mixer] 	mixer selector, i.e 'pulse'" 
	printf "\n -s [step] 	step amount, i.e 10%% or 3dB" 
	echo ""
	exit 1
}

while getopts ":v:s:m:c:" o; do
	case "${o}" in
		v) v=${OPTARG}
			(( v == "dec" || v == "inc" || v == "toggle" )) || usage
			;;
		c) c=${OPTARG}
			;;
		m) m=${OPTARG}
			;;
		s) s=${OPTARG}
			;;
		*) usage
			;;
	esac
done

# Checks if volume control has an option, required
if [ -z "${v}" ]; then
    usage
fi

# Tries to detect mixer, if it can't it will use
# the default one or one specified.
MIXER="default"
lsmod | grep -q pulse && MIXER="pulse"
lsmod | grep -q jack && MIXER="jackplug"
MIXER="${m:-$MIXER}"

# The instance option sets the control to report and configure
# This defaults to the first control of your selected mixer
# For a list of the available, use `amixer -D $Your_Mixer scontrols`
SCONTROL="${c:-$(amixer -D "$MIXER"  scontrols |
                  sed -n "s/Simple mixer control '\([A-Za-z ]*\)',0/\1/p" |
                  head -n1
                )}"
STEP="${s:-5%}"

capability() { # Return "Capture" if the device is a capture device
  amixer -D "$MIXER"  get "$SCONTROL"  |
    sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

case ${v} in
	"toggle") amixer -q -D "$MIXER" sset "$SCONTROL" "$(capability)"  toggle
		;;
	"inc"	) amixer -q -D "$MIXER" sset "$SCONTROL" "$(capability)" "${STEP}"+ unmute
		;;
	"dec"	) amixer -q -D "$MIXER" sset "$SCONTROL" "$(capability)" "${STEP}"- unmute
		;;
esac

pkill -SIGRTMIN+10 i3blocks
