if test -n "${WSL_DISTRO_NAME}"; then
    APPDATA="$(wslvar appdata)"
    APPDATA="${APPDATA//\\/\/}"

    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
    ss -a | grep -q $SSH_AUTH_SOCK
    if [ $? -ne 0 ]; then
        rm -f $SSH_AUTH_SOCK
        ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
    fi

    export GPG_SOCK="$HOME/.gnupg/S.gpg-agent"
    if ! ss -a | grep -q "$GPG_SOCK"; then
        rm -f "$GPG_SOCK"
        mkdir -p "$(dirname "$GPG_SOCK")"
        ( setsid socat UNIX-LISTEN:"$GPG_SOCK",fork EXEC:"npiperelay.exe -ei -ep -s -a "'"'"$APPDATA"/gnupg/S.gpg-agent'"',nofork & ) >/dev/null 2>&1
    fi

    "/mnt/c/Program Files (x86)/GnuPG/bin/gpg-connect-agent.exe" /bye
fi
