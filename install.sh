#!/bin/bash
#
#	Written by R0flcopt3r
#
#	This program installs all my dotfiles in their corresponding folders. It is
#	not guaranteed to work, nor will I hold myself responsible if it breaks your
#	system in any way.
#
#	Firstly the scripts sets the $chassis variable to determine if your computer is
#	a laptop or a desktop. Then sets the $XDG_CONFIG_HOME variable if it isn't
#	already set.
#
#	dot() checks if the config file you wish to link already exists as a symbolic
#	link or as a regular file. If it's a symbolic links, it assumes all is well and
#	skips it, if it's a regular file, it will delete it and link it in it's place.
#
#	folder() checks to see if a config folder doesn't exist, and if so, creates it.
#
#	To add a new config add the following in the code:
#		`dot /path/to/config /path/to/system/config/location name_of_config`
#
#	If the configs has it's own folder, you want to check it first with:
#		`folder /path/to/system/config/location`



chassis=$(hostnamectl | grep "Chassis" | cut -d ':' -f2)
distro=$(hostnamectl | grep "Operating System" | cut -d ':' -f2 | cut -d ' ' -f2)


if [[ -z $XDG_CONFIG_HOME ]]
then
	echo "XDG_CONFIG_HOME no set, using $HOME/.config"
	XDG_CONFIG_HOME="$HOME"/.config
fi


dot(){ # Path, name, hidden

	if [ -h "$2" ]
	then
		printf "\t%s is symbolic, deleting and linking\n" "$3"
		rm "$2"
		ln -s "$1" "$2"
		printf "\t%s: DONE\n" "$3"
	elif [ -f "$2" ]
	then
		printf "\t%s a regular file, deleting and linking...\n" "$3"
		rm "$2"
		ln -s "$1" "$2"
	elif [ ! -e "$2" ]
	then
		printf "\t%s doesn't exist, linking\n" "$3"
		ln -s "$1" "$2"
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

if [ "$distro"  == "Fedora" ] 
then
	echo "Setting up RPM Fusion" 
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	echo "Installing software"
	sudo dnf copr -y enable atim/i3blocks
	sudo dnf copr -y enable gregw/i3desktop
	sudo dnf install -y --allowerasing i3-gaps
	sudo dnf install -y zsh i3blocks arandr rofi neovim nodejs lxappearance \
		nextcloud-client keepassx blueman NetworkManager network-manager-applet\
			ShellCheck rxvt-unicode-256color-ml

	echo "Installing media codecs" 
	sudo dnf groupupdate -y multimedia
fi

echo "Installing dependencies for neovim" 
sudo pip install pynvim
sudo pip3 install pynvim

echo "Setting keyboard"
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo ""

# Initial checks for various config folders.
echo "Installing oh-my-zsh"
if [[ ! -e $HOME/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Checking and creating folders"
folder "$XDG_CONFIG_HOME"/nvim
folder "$XDG_CONFIG_HOME"/ranger
folder "$XDG_CONFIG_HOME"/i3
folder "$XDG_CONFIG_HOME"/i3blocks

 echo "Checking and copying files"
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
dot "$(pwd)"/i3scripts 			"$XDG_CONFIG_HOME"/i3blocks/scripts		i3script

echo "Checking and copying chassis specific configs"
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


xrdb "$HOME"/.Xresources
