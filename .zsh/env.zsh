#!/usr/bin/env zsh

export EDITOR="emacsclient -n --alternate-editor=emacs"
export LINXURL="https://linx.rflcptr.me/upload/"
export LV2_PATH="/usr/lib64/lv2"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export TERM="alacritty"
export JAVA_HOME=/usr/local/jdk-11.0.2

# Find tumbleweed version
if [ -e /etc/os-release ]; then
   . /etc/os-release
else
   . /usr/lib/os-release
fi
