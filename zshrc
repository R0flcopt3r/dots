# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
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

export PATH="/home/eirik/.pyenv/bin:$PATH:$HOME/.local/bin"
export GOPATH="$HOME/.local/go"
export PATH="$PATH:$GOPATH/bin"
export EDITOR="emacsclient -n --alternate-editor=emacs"
export LINXURL="https://linx.rflcptr.me/upload/"
export LV2_PATH="/usr/lib64/lv2"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export TERM="alacritty"

FZF_DEFAULT_COMMAND="fd --type f"
FZF_CTRL_T_COMMAND="fd --type f"
FZF_ALT_C_COMMAND="fd --type d"

# https://github.com/sindresorhus/pure
if [ -e "$HOME/.zsh/pure" ]; then
	fpath+=$HOME/.zsh/pure
	autoload -U promptinit; promptinit
	prompt pure
else
	mkdir -p "$HOME/.zsh"
	git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

[ -e /etc/zsh_completion.d/fzf-key-bindings ] && source /etc/zsh_completion.d/fzf-key-bindings

edit(){
	# usage: edit [OPTION] /path/to/file
	eval $EDITOR $@
}
alias e=edit

#Alias for the LS comand
alias ll='ls -hAl --group-directories-first'
alias l='ls -GghB --group-directories-first'
alias lc='ls -gGht'
alias llc='ls -hAlt'

alias dirs='dirs -v'

# Alias for Git
alias gc='git_clone'
git_clone (){
	clip=$(xclip -sel clip -o)
	[ ! -z $1 ] && (
		git clone "$1"
		exit
	)
	[[ "$clip" =~ "^git@.*\.git$" ]] && git clone "$clip" || echo "clipboard does not contain git repo"
}

# General alias
alias c='xclip -sel clip'
alias p='xclip -sel clip -o'


alias -s {pdf,png,jpg,jpeg,mp4}=open_file

# text files
alias -s {md,txt,org}=edit

# Programming
alias -s {rs,go,toml,json,cpp,c,h,hpp}=edit

alias -g ls='ls --color'

# Open file
open_file(){
	devour xdg-open $1 &
}
alias open="open_file"
alias :q=exit
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
	  *.tar.xz)		 tar xf $1	;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

linx(){
	link=$(curl --silent --upload-file $1 "$LINXURL" || echo "error"; exit 1)

	(echo "$link" | xclip -sel clip)\
		&& notify-send "File url copied to clipboard" "$link"
}
