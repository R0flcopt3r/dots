#!/usr/bin/env sh

usage() {
	printf "%s [options]\n" "$0"
	printf "\t-h\t\tdisplays usage\n"
	printf "\t-u <url>\tsets the linx url\n"
	printf "\t-s\t\tscreenshot a selection\n"
	printf "\t-d <display>\tX display to use"
	printf '\nUses `$LINXURL` if set\n'
}


[ ! "$(command -v scrot)" ] && echo "Scrot is not installed" && exit 1

while getopts "hu:sd:" o; do
	case "${o}" in
		h) usage "$0"
		   exit 0
		   ;;
		u) url=${OPTARG}
		   ;;
		s) sel="-s"
		   ;;
		d) DISPLAY=${OPTARG}
		   ;;
		*) ;;
	esac
done

url="${url:-$LINXURL}"

link=$(DISPLAY=$DISPLAY scrot -e \
	'(
		curl -s -H "Linx-Randomize: yes" -T $f "'"$url"'" && rm $f
	) || echo "Curl failed"; exit 1 '\
		$sel || echo "Scrot failed"; exit 1)

(echo "$link" | xclip -sel clip)\
	&& notify-send "Screenshot url copied to clipboard" "$link"

exit 0
