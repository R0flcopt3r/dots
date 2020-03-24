#!/usr/bin/env sh

usage() {

	cat <<'EOF'
Takes a screenshot using `scrot` and uploads it to a linx host using `curl` and puts the link into the clipboard.

EOF

	printf "%s [options]\n" "$0"
	printf "\t-h\t\tdisplays usage\n"
	printf "\t-u <url>\toverwrites \$LINXURL variable with url\n"
	printf "\t-s\t\tscreenshot a selection\n"
	printf "\t-d <display>\tX display to use\n"
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
