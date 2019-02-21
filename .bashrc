# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable custom bash completion
if [ -d ~/.bash_completion.d ]; then
    for FILE in ~/.bash_completion.d/* ; do
      [ -f "${FILE}" ] && . ${FILE}
    done
fi
if [ -d ~/.local/etc/bash_completion.d ]; then
    for FILE in ~/.local/etc/bash_completion.d/* ; do
      [ -f "${FILE}" ] && . ${FILE}
    done
fi

# go to user home
cd ~

# tools
if type most >/dev/null; then
    export PAGER=most
fi
if type vim >/dev/null; then
    export EDITOR=vim
fi

if ! tmux display 2>/dev/null; then
    exec tmux
fi

# add beatiful prompt (powerline-go)
if test -x ~/.local/bin/powerline-go; then
    function _update_ps1() {
        PS1="$(~/.local/bin/powerline-go -error $? -modules exit,user,cwd,git,jobs -newline)"
    }
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
