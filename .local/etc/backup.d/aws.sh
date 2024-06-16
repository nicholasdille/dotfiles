#!/bin/bash
set -o errexit

if test -f "${HOME}/.aws/config"; then
    echo "${HOME}/.aws/config"
fi
