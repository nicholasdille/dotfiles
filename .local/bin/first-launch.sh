#!/bin/bash

if ! test -f "${HOME}/.local/etc/first-launch-done"; then

    echo "### FIRST LAUNCH START"

    if ! sudo true; then
        echo "ERROR: Unable to sudo"
        exit 1
    fi

    mkdir -p "${HOME}/.gnupg"
    chmod --quiet 0700 "${HOME}/.gnupg"
    
    sudo add-apt-repository ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get -y install --no-install-recommends \
        git \
        most \
        curl \
        jq \
        ca-certificates \
        socat \
        apt-transport-https \
        unzip \
        wslu

    cat ~/.gitconfig* | \
        grep signingkey | \
        tr -s ' ' | \
        cut -d' ' -f4 | \
        while read KEY; do
            if ! gpg --list-secret-keys | grep "^ssb" | grep -q "/0x${KEY}"; then
                echo "Oh no, GPG key 0x${KEY} is missing for git commit signing"
            fi
        done

    echo "### FIRST LAUNCH DONE"
    touch "${HOME}/.local/etc/first-launch-done"

fi
