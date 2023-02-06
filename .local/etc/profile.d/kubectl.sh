#!/bin/bash

if type kubectl >/dev/null 2>&1; then
    complete -F __start_kubectl k
fi

export PATH="${PATH}:${HOME}/.krew/bin"
