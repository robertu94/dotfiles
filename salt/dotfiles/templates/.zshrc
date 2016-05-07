#!/usr/bin/zsh

# Completion 
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/runderwood/.zshrc'

autoload -Uz compinit
compinit

# History 
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt appendhistory autocd extendedglob

# Directory Stack (wiki.archlinux.org/index.php/Zsh)
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
	dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
	[[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
	print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

# Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus
# END (wiki.archlinux.org/index.php/Zsh)
# }}}

# Prompt settings
autoload -U promptinit
promptinit
prompt redhat

# Set up editing commands from the prompt
autoload -z edit-command-line
zle -N edit-command-line

#Delete to paths by default when using ^W
autoload -U select-word-style
select-word-style bash

# Keybindings
bindkey -e
bindkey "^X^E" edit-command-line

screensaveroff(){
	xset dpms 7200 7200 7200
	xset s 7200 7200
}


if [ -f $HOME/.profile ]; then
	. $HOME/.profile
fi

# vim: foldmethod=marker:
