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

# tools
export PAGER=most
export EDITOR=vim

# add docker completion
# see: https://github.com/docker/cli/tree/master/contrib/completion/bash
. ~/.docker-completion

# using pagent / Keepass for Authentication
# see: https://solariz.de/de/ubuntu-subsystem-windows-keepass-keeagent-pageant-linux-ssh.htm
# killing old running socket
echo -n "pageant:"
if [ -L "${HOME}/home" ]; then
    eval $(~/home/Documents/Apps/weasel-pageant/weasel-pageant -r -a "/tmp/.weasel-pageant-$USER") >/dev/null 2>/dev/null
    sleep .5
    SSHADDL=$(ssh-add -l 2>&1)
    KEYS=$(echo ${SSHADDL} | grep -c SHA)
    if echo ${SSHADDL} | grep -q "agent refused operation"; then
        echo -e "\e[91m Agent connection failed."
    else
        echo -e "\e[92m Connected to agent with ${KEYS} key(s)."
    fi
    echo

else
    echo -e "\e[91m Missing symlink from ~/home to Windows %UserProfile%"
fi

# add beautiful prompt
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
