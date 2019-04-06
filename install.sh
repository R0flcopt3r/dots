#!/bin/bash

echo "Creating symlink for neovim..."
ln -s $(pwd)/neovim $XDG_CONFIG/nvim

echo "Creating symlink for i3WM..."
ln -s $(pwd)/i3wm $XDG_CONFIG/i3

echo "Creating symlink for i3blocks..."
ln -s $(pwd)/i3blocks $XDG_CONFIG/i3blocks

echo "Creating symlink for Ranger..."
ln -s $(pwd)/ranger $XDG_CONFIG/ranger

echo "Creating symlink for URxvt..."
ln -s $(pwd)/urxvt/Xresources $HOME/.Xresources

echo "Creating symlink for zsh..."
ln -s $(pwd)/zsh/zshrc $HOME/.zshrc

xrdb $HOME/.Xresources

