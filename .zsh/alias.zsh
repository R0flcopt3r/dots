#!/usr/bin/env zsh

alias e='emacsclient -n --alternate-editor=emacs'

#Alias for the LS comand
alias ll='ls -hAl --group-directories-first'
alias l='ls -GghB --group-directories-first'
alias lc='ls -gGht'
alias llc='ls -hAlt'

alias dirs='dirs -v'

alias gc='git_clone'

# General alias
alias c='xclip -sel clip'
alias p='xclip -sel clip -o'


alias -s {pdf,png,jpg,jpeg,mp4}=open_file

# text files
alias -s {md,txt,org}=edit

# Programming
alias -s {rs,go,toml,json,cpp,c,h,hpp}=edit

alias -g ls='ls --color'
alias open="open_file"
alias :q=exit

alias zypper='sudo zypper'
alias dnf='sudo dnf'
alias zy='sudo zypper'

alias kc='kubectl'

alias tf='terraform'
