# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable for debugging
#PS4='+ $(date "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

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

# tools
if type most >/dev/null 2>&1; then
    export PAGER=most
fi
if type vim >/dev/null 2>&1; then
    export EDITOR=vim
fi

if test -f "${HOME}/.local/bin/first-launch.sh"; then
    source "${HOME}/.local/bin/first-launch.sh"
fi

source ${HOME}/.local/etc/profile.d/@homebrew.sh
for FILE in ${HOME}/.local/etc/profile.d/*.sh; do
    #echo "Sourcing ${FILE}"
    source ${FILE}
done

# enable for debugging
#set +x
#exec 2>&3 3>&-
