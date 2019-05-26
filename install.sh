#!/bin/bash

chassis=$(hostnamectl | grep "Chassis" | cut -d ':' -f2)

if [[ -z $XDG_CONFIG_HOME ]]
then
	echo "XDG_CONFIG_HOME no set, using $HOME/.config"
	XDG_CONFIG_HOME="$HOME"/.config
fi

dot(){ # Path, name, hidden

	if [ -h "$2" ]
	then
		printf "\t%s is symbolic, doing nothing\n" "$3"
	elif [ -f "$2" ]
	then
		printf "\t%s a regular file, deleting...\n" "$3"
		rm "$2"
		printf "\tLinking\n"
		ln -s "$1" "$2"
		printf "\t%s is done\n" "$3"
	else
		printf "\tERROR: Can't determine.\n"
		file "$1"
	fi

}

folder(){
	if [[ ! -e $1 ]]
	then
		printf "\t%s does not exist, creating...\n" "$1"
		mkdir "$1"
	fi
}

# Initial checks for various config folders.
echo "Installing oh-my-zsh"
if [[ ! -e $HOME/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

printf "Checking and creating folders\n"
folder "$XDG_CONFIG_HOME"/nvim
folder "$XDG_CONFIG_HOME"/ranger
folder "$XDG_CONFIG_HOME"/i3
folder "$XDG_CONFIG_HOME"/i3blocks

printf "Checking and copying files\n"
dot "$(pwd)"/urxvt/Xresources 	"$HOME"/.Xresources						Xresources
dot "$(pwd)"/zsh/zshrc 			"$HOME"/.zshrc							Zshrc
dot "$(pwd)"/neovim/init.vim 	"$XDG_CONFIG_HOME"/nvim/init.vim		Init.vim
dot "$(pwd)"/neovim/UltiSnips 	"$XDG_CONFIG_HOME"/nvim/UltiSnips		UltiSnips
dot "$(pwd)"/neovim/spell 		"$XDG_CONFIG_HOME"/nvim/spell			Spelling
dot "$(pwd)"/neovim/ftdetect 	"$XDG_CONFIG_HOME"/nvim/ftdetect		Filecheck
dot "$(pwd)"/ranger/rc.conf 	"$XDG_CONFIG_HOME"/ranger/rc.conf 		rc.conf
dot "$(pwd)"/ranger/rifle.conf 	"$XDG_CONFIG_HOME"/ranger/rifle.conf 	rifle
dot "$(pwd)"/ranger/scope.sh 	"$XDG_CONFIG_HOME"/ranger/scope.sh 		scope
dot "$(pwd)"/ranger/tagged 		"$XDG_CONFIG_HOME"/ranger/tagged 		tagged
dot "$(pwd)"/ranger/bookmarks 	"$XDG_CONFIG_HOME"/ranger/bookmarks 	bookmarks

printf "Checking and copying chassis specific configs\n"
if [ "$chassis" == " desktop" ]
then
	echo "doing desktop"
	dot "$(pwd)"/desktop/i3wm/config 	"$XDG_CONFIG_HOME"/i3/config 	i3wm
	dot "$(pwd)"/desktop/i3blocks/config "$XDG_CONFIG_HOME"/i3blocks/config i3blocks
elif [ "$chassis" == " laptop" ]
then
	echo "doing laptop"
	dot "$(pwd)"/laptop/i3wm/config 	"$XDG_CONFIG_HOME"/i3/config 	i3wm
	dot "$(pwd)"/laptop/i3blocks/config "$XDG_CONFIG_HOME"/i3blocks/config i3blocks
fi

dot "$(pwd)"/i3blocks/scripts "$XDG_CONFIG_HOME"/i3blocks/scripts i3blocksscripts

xrdb "$HOME"/.Xresources
