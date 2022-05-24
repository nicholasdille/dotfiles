#!/bin/bash

if ! test -f "${HOME}/.local/etc/first-launch-done"; then

    echo "### FIRST LAUNCH START"

    if ! sudo true; then
        echo "ERROR: Unable to sudo"
        exit 1
    fi

    mkdir -p "${HOME}/.gnupg"
    chmod --quiet 0700 "${HOME}/.gnupg"
    
    sudo apt-get update
    sudo apt-get -y install \
        most \
        curl \
        jq \
        ca-certificates \
        socat \
        apt-transport-https \
        unzip \
        wslu

    if test -n "${WSL_DISTRO_NAME}"; then
        curl -sLo /tmp/win-gpg-agent.zip https://github.com/rupor-github/win-gpg-agent/releases/download/v1.6.3/win-gpg-agent.zip
        sudo unzip -d /usr/local/bin/ /tmp/win-gpg-agent.zip sorelay.exe

        ln -s /mnt/c/Users/$(wslvar USERNAME) ${HOME}/home
    fi

    sudo curl -sLo /etc/apt/trusted.gpg.d/wsl-transdebian.gpg https://arkane-systems.github.io/wsl-transdebian/apt/wsl-transdebian.gpg
    sudo chmod a+r /etc/apt/trusted.gpg.d/wsl-transdebian.gpg
    sudo tee /etc/apt/sources.list.d/wsl-transdebian.list >/dev/null <<EOF
deb https://arkane-systems.github.io/wsl-transdebian/apt/ $(lsb_release -cs) main
deb-src https://arkane-systems.github.io/wsl-transdebian/apt/ $(lsb_release -cs) main
EOF
    curl -sLo /tmp/packages-microsoft-prod.deb https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb
    sudo dpkg -i /tmp/packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get -y install \
        systemd-genie

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
        #brew bundle --file ${HOME}/Brewfile

        mkdir -p ${HOME}/.local/share
        ln -s /home/linuxbrew/.linuxbrew/share/fonts ${HOME}/.local/share/fonts
        fc-cache -fv
    fi

    echo "### FIRST LAUNCH DONE"
    touch "${HOME}/.local/etc/first-launch-done"

fi
