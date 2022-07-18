#!/bin/bash
set -o errexit

if test -f "${HOME}/.config/hcloud/cli.toml"; then
    echo "${HOME}/.config/hcloud/"
fi
