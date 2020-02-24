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

# tools
if type most >/dev/null; then
    export PAGER=most
fi
if type vim >/dev/null; then
    export EDITOR=vim
fi

# configure tmux
if [[ -z "${TMUX}" ]]; then
    tmux ls | grep -vq attached && TMUXARG="attach-session -d"
    exec tmux -2 $TMUXARG
fi

# add beatiful prompt (powerline-go)
if test -x ~/.local/bin/powerline-go; then
    function _update_ps1() {
        PS1="$(~/.local/bin/powerline-go -error $? -modules exit,user,cwd,git,jobs -newline)"
    }
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
else
    if ! test -f ~/.local/etc/git-prompt.sh; then
        mkdir -p ~/.local/etc
        git_version=$(git --version | cut -d' ' -f3)
        echo Installing git-prompt.sh v${git_version}
        curl -sLo ~/.local/etc/git-prompt.sh https://raw.githubusercontent.com/git/git/v${git_version}/contrib/completion/git-prompt.sh
    fi
    source ~/.local/etc/git-prompt.sh
    export GIT_PS1_SHOWCOLORHINTS=true
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    export PROMPT_COMMAND='__git_ps1 "\[\033[0;36m\]\u\[\033[0;35;40m\]@\h\[\033[0;37;0m\] \[\033[1;33m\]\W\[\033[0;37;0m\] [\j]" " \\\$ "'
fi

if ! test -f ~/.local/etc/kube-tmux.sh; then
    mkdir -p ~/.tmux/kube-tmux
    curl -sLo ~/.local/etc/kube-tmux.sh https://raw.githubusercontent.com/jonmosco/kube-tmux/master/kube.tmux
    patch ~/.local/etc/kube-tmux.sh < ~/.local/etc/kube-tmux.sh.patch
fi

# configure golang
GOROOT=~/.local/go
if [[ -f $GOROOT/bin/go ]] && [[ -x $GOROOT/bin/go ]]; then
    export GOROOT=~/.local/go
    PATH=$GOROOT/bin:$PATH

else
    GOROOT=$(ls -d /usr/lib/go-* 2>/dev/null | sort -n | tail -n 1)
    if [[ -f $GOROOT/bin/go ]] && [[ -x $GOROOT/bin/go ]]; then
        export GOROOT
        PATH=$GOROOT/bin:$PATH

    else
        unset GOROOT
    fi
fi
export GOPATH=$HOME/go
PATH=$GOPATH/bin:$PATH

# configure GnuPG
export GPG_TTY=$(tty)
if [ -f "${HOME}/.gnupg/S.gpg-agent.ssh" ]; then
    export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh
else
    eval $(gpg-agent --daemon 2>/dev/null)
fi

# aliases
export KUBECONFIG=~/.kube/config:$(ls ~/.kube/kubeconfig.* 2>/dev/null | tr '\n' ':')
alias k=kubectl
complete -F __start_kubectl k
