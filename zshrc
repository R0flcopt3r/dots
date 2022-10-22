# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle :compinstall filename '/home/eirik/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt autocd extendedglob
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

PROMPT='%F{blue}%~ %F{green}@virt%(!.#.>)%f '
EDITOR="emacsclient -c --alternate-editor=emacs"
WORDCHARS='*?~=^!%^'


alias ls='ls --color'
alias ll='ls -hAl --group-directories-first --color'
alias l='ls -GghB --group-directories-first --color'
alias lc='ls -gGht --color'
alias llc='ls -hAlt --color'
alias zypper='sudo zypper'
alias dnf='sudo dnf'
alias zy='sudo zypper'
alias e='emacsclient -n --alternate-editor=emacs'
alias c='wl-copy'
alias p='cl-paste'


#### FZF ####
# Tumbleweed
[ -e /etc/zsh_completion.d/fzf-key-bindings ] &&
  . /etc/zsh_completion.d/fzf-key-bindings
# Fedora
[ -e ~/.fzf.zsh ] &&
  . ~/.fzf.zsh
FZF_DEFAULT_COMMAND="fd --type f"
FZF_CTRL_T_COMMAND="fd --type f"
FZF_ALT_C_COMMAND="fd --type d"
DISABLE_FZF_AUTO_COMPLETION="false"

