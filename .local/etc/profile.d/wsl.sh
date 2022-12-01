if test -n "${WSL_DISTRO_NAME}" && type sorelay.exe >/dev/null 2>&1; then

    export SSH_AUTH_SOCK="${HOME}/.ssh/agent.sock"
    if ! ss -a | grep -q "${SSH_AUTH_SOCK}"; then
        echo "Setting up socket for SSH agent"

        rm -f "${SSH_AUTH_SOCK}"
        mkdir -p "$(dirname "${SSH_AUTH_SOCK}")"
        ( setsid socat UNIX-LISTEN:"${SSH_AUTH_SOCK}",fork EXEC:"sorelay.exe -a //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
    fi

    if test -f "/mnt/c/Program Files (x86)/GnuPG/bin/gpg-connect-agent.exe"; then
        export GPG_SOCK="${HOME}/.gnupg/S.gpg-agent"
        if ! ss -a | grep -q "${GPG_SOCK}"; then
            echo "Setting up socket for GPG agent"

            APPDATA="$(wslvar localappdata)"
            APPDATA="${APPDATA//\\/\/}"

            rm -f "${GPG_SOCK}"
            mkdir -p "$(dirname "${GPG_SOCK}")"
            ( setsid socat UNIX-LISTEN:"${GPG_SOCK}",fork EXEC:"sorelay.exe -a "'"'"${APPDATA}"/gnupg/S.gpg-agent'"',nofork & ) >/dev/null 2>&1
        fi

        # Check that %AppData%\gnupg\gpg-agent.conf contains enable-ssh-support and enable-putty-support

        "/mnt/c/Program Files (x86)/GnuPG/bin/gpg-connect-agent.exe" /bye
    fi

fi
