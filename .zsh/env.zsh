#!/usr/bin/env zsh

export EDITOR="emacsclient -c --alternate-editor=emacs"
export LINXURL="https://linx.rflcptr.me/upload/"
export LV2_PATH="/usr/lib64/lv2"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export TERM="alacritty"
export JAVA_HOME="/opt/jdk-15.0.1"
export FrameworkPathOverride=/lib/mono/4.5
export MOZ_DBUS_REMOTE=1

GUIX_PROFILE="/home/eirik/.config/guix/current"
. "$GUIX_PROFILE/etc/profile"

# Find tumbleweed version
if [ -e /etc/os-release ]; then
   . /etc/os-release
else
   . /usr/lib/os-release
fi
