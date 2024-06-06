#!/bin/bash
set -o errexit

if test -f "${HOME}/.config/glab-cli/config.yml"; then
    echo "${HOME}/.config/glab-cli/"
fi
