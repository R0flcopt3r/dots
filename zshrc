# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '/home/eirik/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

. $HOME/.zsh/env.zsh
. $HOME/.zsh/path.zsh
. $HOME/.zsh/alias.zsh
. $HOME/.zsh/functions.zsh

# https://github.com/sindresorhus/pure
if [ -e "$HOME/.zsh/pure/pure.zsh" ]; then
	fpath+=$HOME/.zsh/pure
	autoload -U promptinit; promptinit
	prompt pure
fi

#### FZF ####
# Tumbleweed
[ -e /etc/zsh_completion.d/fzf-key-bindings ] &&
  source /etc/zsh_completion.d/fzf-key-bindings
# Fedora
[ -e ~/.fzf.zsh ] &&
  source ~/.fzf.zsh
FZF_DEFAULT_COMMAND="fd --type f"
FZF_CTRL_T_COMMAND="fd --type f"
FZF_ALT_C_COMMAND="fd --type d"
