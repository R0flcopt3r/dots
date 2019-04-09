#!/bin/bash

if [[ -z $XDG_CONFIG_HOME ]]
then
	echo "XDG_CONFIG_HOME no set, using $HOME/.config"
	XDG_CONFIG_HOME=$HOME/.config
fi


echo "Creating symlink for URxvt..."
if [[ $(file $HOME/.Xresources | awk '{print$2}') -ne "symbolic" ]]
then
	echo "Xresouces exists as a regular file, deleting and linking"
	rm $HOME/.Xresouces
fi
ln -s $(pwd)/urxvt/Xresources $HOME/.Xresources

echo "Creating symlink for zsh..."
if [[ $(file ~/.zshrc | awk '{print$2}') -eq "symbolic" ]]
then
	echo "Zshrc exists as a regular file, deleting and linking"
	rm $HOME/.zshrc
fi
ln -s $(pwd)/zsh/zshrc $HOME/.zshrc
echo "Installing oh-my-zsh"

if [[ ! -e $HOME/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Creating symlink for neovim..."
if [[ ! -e $XDG_CONFIG_HOME/nvim ]]
then
	echo "$XDG_CONFIG_HOME/nvim/ does not exist, creating.."
	mkdir $XDG_CONFIG_HOME/nvim
fi

	ln -s $(pwd)/neovim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
	ln -s $(pwd)/neovim/UltiSnips $XDG_CONFIG_HOME/nvim/UltiSnips
	ln -s $(pwd)/neovim/spell $XDG_CONFIG_HOME/nvim/spell
	ln -s $(pwd)/neovim/ftdetect $XDG_CONFIG_HOME/nvim/ftdetect


echo "Creating symlink for i3WM..."
if [[ ! -e $XDG_CONFIG_HOME/i3 ]]
then
	echo "$XDG_CONFIG_HOME/i3/ does not exist, creating.."
	mkdir $XDG_CONFIG_HOME/i3
fi
if [[ $(file $XDG_CONFIG_HOME/i3/config | awk '{print$2}') -ne "symbolic" ]]
then
	echo "i3/config exists as a regular file, deleting and linking"
	rm $XDG_CONFIG_HOME/i3/config
fi
ln -s $(pwd)/i3wm/config $XDG_CONFIG_HOME/i3/config

echo "Creating symlink for i3blocks..."
if [[ ! -e $XDG_CONFIG_HOME/i3blocks ]]
then
	echo "i3blocks/config exists as a regular file, deleting and linking"
	mkdir $XDG_CONFIG_HOME/i3blocks
fi
if [[ $(file $XDG_CONFIG_HOME/i3/config | awk '{print$2}') -ne "symbolic" ]]
then
	echo "i3blocks/config exists as a regular file, deleting and linking"
	rm $XDG_CONFIG_HOME/i3blocks/config
fi
ln -s $(pwd)/i3blocks/config $XDG_CONFIG_HOME/i3blocks/config

echo "Creating symlink for Ranger..."
if [[ ! -e $XDG_CONFIG_HOME/ranger ]]
then
	echo "i3/ranger exists as a regular file, deleting and linking"
	mkdir $XDG_CONFIG_HOME/ranger
fi
ln -s $(pwd)/ranger/rc.conf $XDG_CONFIG_HOME/ranger/rc.conf
ln -s $(pwd)/ranger/rifle.conf $XDG_CONFIG_HOME/ranger/rifle.conf
ln -s $(pwd)/ranger/scope.sh $XDG_CONFIG_HOME/ranger/scope.sh
ln -s $(pwd)/ranger/tagged $XDG_CONFIG_HOME/ranger/tagged
ln -s $(pwd)/ranger/bookmarks $XDG_CONFIG_HOME/ranger/bookmarks


xrdb $HOME/.Xresources

