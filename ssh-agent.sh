#!/bin/bash

# using pagent / Keepass for Authentication
# see: https://solariz.de/de/ubuntu-subsystem-windows-keepass-keeagent-pageant-linux-ssh.htm
# killing old running socket
echo -n "pageant:"

if test -L "${HOME}/home"; then

    if test -S /tmp/.weasel-pageant-dillen; then
        export SSH_AUTH_SOCK=/tmp/.weasel-pageant-dillen
        export SSH_PAGEANT_PID=$(ps -C weasel-pageant -o pid --no-headers)

    else
        eval $(~/home/Documents/Apps/weasel-pageant/weasel-pageant -r -a "/tmp/.weasel-pageant-$USER") >/dev/null 2>/dev/null
        sleep .5
    fi

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
