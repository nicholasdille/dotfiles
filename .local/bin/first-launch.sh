#!/bin/bash

if ! test -f "${HOME}/.local/etc/first-launch-done"; then

    echo "### FIRST LAUNCH START"

    sudo true

    chmod 0700 "${HOME}.gnupg"

    if test -n "${WSL_DISTRO_NAME}"; then
        sudo curl -sLo /usr/local/bin/npiperelay.exe https://github.com/NZSmartie/npiperelay/releases/download/v0.1/npiperelay.exe
        sudo chmod +x /usr/local/bin/npiperelay.exe

        ln -s /mnt/c/Users/$(wslvar USERNAME) ${HOME}/home
    fi

    sudo apt-get update
    sudo apt-get -y install \
        most \
        curl \
        jq \
        ca-certificates \
        socat

    cat ~/.gitconfig* | \
        grep signingkey | \
        tr -s ' ' | \
        cut -d' ' -f4 | \
        while read KEY; do
            if ! gpg --list-secret-keys | grep "^ssb" | grep -q "/0x${KEY}"; then
                echo "Oh no, GPG key 0x${KEY} is missing for git commit signing"
            fi
        done

    if ! test -x /home/linuxbrew/.linuxbrew/bin/brew; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        source "${HOME}/.local/etc/profile.d/@homebrew.sh"
        brew install gcc
        brew bundle --file ${HOME}/Brewfile
    fi

    echo "### FIRST LAUNCH DONE"
    touch "${HOME}/.local/etc/first-launch-done"

fi
