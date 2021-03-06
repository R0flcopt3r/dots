# The following lines were added by compinstall

zstyle :compinstall filename '/home/eirik/.zshrc'

fpath+=~/.zfunc
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

. $HOME/.zsh/completion.zsh
. $HOME/.zsh/env.zsh
. $HOME/.zsh/path.zsh
. $HOME/.zsh/alias.zsh
. $HOME/.zsh/functions.zsh
. $HOME/.zsh/completion/*.zsh

WORDCHARS='*?~=^!%^'

# https://github.com/sindresorhus/pure
if [ -e "$HOME/.zsh/pure/pure.zsh" ]; then
	fpath+=$HOME/.zsh/pure
	autoload -U promptinit; promptinit
	prompt pure
fi

if [ -e "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  . $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

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

hash -d bachelor=$HOME/Git/School/bachelor
hash -d code=$HOME/Git/School/bachelor/code
hash -d thesis=$HOME/Git/School/bachelor/reports/thesis
hash -d dots=$HOME/Git/dots
hash -d srv=$HOME/Git/kad-server
