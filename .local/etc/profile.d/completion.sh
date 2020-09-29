if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -d /usr/local/etc/bash_completion.d ]; then
    for FILE in /usr/local/etc/bash_completion.d/* ; do
      [ -f "${FILE}" ] && . ${FILE}
    done
fi

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
