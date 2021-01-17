#!/usr/bin/env zsh

git_clone (){
	clip=$(xclip -sel clip -o)
	[ ! -z $1 ] && (
		git clone "$1"
		exit
	)
	[[ "$clip" =~ "^git@.*\.git$" ]] && git clone "$clip" || echo "clipboard does not contain git repo"
}


open_file(){
	if [ $(command -v devour) ]; then
		devour xdg-open $1 &
	else
		xdg-open $1 &
	fi
}
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
	  *.tar.xz)		 tar xf $1	;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

linx(){
	link=$(curl --silent --upload-file $1 "$LINXURL" || echo "error"; exit 1)

	(echo "$link" | xclip -sel clip)\
		&& notify-send "File url copied to clipboard" "$link"
}

# Checks if a port ($2) is reachable on a host ($1)
port_open(){
  (echo >/dev/tcp/"$1"/"$2") &>/dev/null && echo "open" || echo "closed"
}
