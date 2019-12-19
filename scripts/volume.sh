#!/bin/bash
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>
# Copyright (C) 2014 Alexander Keller <github@nycroth.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#------------------------------------------------------------------------

# The second parameter overrides the mixer selection
# For PulseAudio users, use "pulse"
# For Jack/Jack2 users, use "jackplug"
# For ALSA users, you may use "default" for your primary card
# or you may use hw:# where # is the number of the card desired
while getopts ":v:i:p:s:" o; do
    case "${o}" in
        v) v=${OPTARG} # Mode
			(( v == "dec" || v == "inc" || v == "mute" )) || usage
			;;
		i) i=${OPTARG} # Instance
			;;
		p) p=${OPTARG} # 
			;;
		s) s=${OPTARG} # Step
			;;
		*) usage
			;;
	esac
done

echo "0: $0 1: $1 2: $2 3: $3" 
echo "${v}"  "$v" 
echo "${i}"  "$i" 
echo "${p}"  "$p" 

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }


MIXER="default"
lsmod | grep -q pulse && MIXER="pulse"
lsmod | grep -q jack && MIXER="jackplug"
MIXER="${v:-$MIXER}"

# The instance option sets the control to report and configure
# This defaults to the first control of your selected mixer
# For a list of the available, use `amixer -D $Your_Mixer scontrols`
SCONTROL="${i:-$(amixer -D "$MIXER"  scontrols |
                  sed -n "s/Simple mixer control '\([A-Za-z ]*\)',0/\1/p" |
                  head -n1
                )}"

# The first parameter sets the step to change the volume by (and units to display)
# This may be in in % or dB (eg. 5% or 3dB)
STEP="${s:-5%}"

#------------------------------------------------------------------------

capability() { # Return "Capture" if the device is a capture device
  amixer -D "$MIXER"  get "$SCONTROL"  |
    sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

volume() {
  amixer -D "$MIXER"  get "$SCONTROL"  "$(capability)" 
}

#------------------------------------------------------------------------


case ${v} in
  "mute" ) amixer -q -D "$MIXER" sset "$SCONTROL" "$(capability)" toggle  # right click, mute/unmute
	  	;;
  "inc" ) amixer -q -D "$MIXER" sset "$SCONTROL" "$(capability)" "${STEP}"+ unmute # scroll up, increase
		;;
  "dec" ) amixer -q -D "$MIXER" sset "$SCONTROL" "$(capability)" "${STEP}"- unmute # scroll down, decrease
		;;
esac

pkill -SIGRTMIN+10 i3blocks
