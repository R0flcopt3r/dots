#!/bin/bash

if [[ -z $XDG_CONFIG_HOME ]]
then
	echo "XDG_CONFIG_HOME no set, using $HOME/.config/"
	XDG_CONFIG_HOME=$HOME/.config/
fi


echo "Creating symlink for URxvt..."
ln -s $(pwd)/urxvt/Xresources $HOME/.Xresources

echo "Creating symlink for zsh..."
ln -s $(pwd)/zsh/zshrc $HOME/.zshrc

echo "Creating symlink for neovim..."
ln -s $(pwd)/neovim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
ln -s $(pwd)/neovim/UltiSnips $XDG_CONFIG_HOME/nvim/UltiSnips
ln -s $(pwd)/neovim/spell $XDG_CONFIG_HOME/nvim/spell
ln -s $(pwd)/neovim/ftdetect $XDG_CONFIG_HOME/nvim/ftdetect


echo "Creating symlink for i3WM..."
ln -s $(pwd)/i3wm/config $XDG_CONFIG_HOME/i3/config

echo "Creating symlink for i3blocks..."
ln -s $(pwd)/i3blocks/config $XDG_CONFIG_HOME/i3blocks/config

echo "Creating symlink for Ranger..."
ln -s $(pwd)/ranger/rc.config $XDG_CONFIG_HOME/ranger/rc.config
ln -s $(pwd)/ranger/rifle.conf $XDG_CONFIG_HOME/ranger/rifle.conf
ln -s $(pwd)/ranger/scope.sh $XDG_CONFIG_HOME/ranger/scope.sh
ln -s $(pwd)/ranger/tagged $XDG_CONFIG_HOME/ranger/tagged
ln -s $(pwd)/ranger/bookmarks $XDG_CONFIG_HOME/ranger/bookmarks


xrdb $HOME/.Xresources

