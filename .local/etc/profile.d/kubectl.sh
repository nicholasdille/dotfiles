#!/bin/bash

if type kubectl >/dev/null 2>&1; then
    KUBECONFIG_FILES=$(ls ${HOME}/.kube/{kube,}config.* 2>/dev/null)
    export KUBECONFIG=${HOME}/.kube/config:$(echo ${KUBECONFIG_FILES} | tr ' ' ':')
    complete -F __start_kubectl k
fi

export PATH="${PATH}:${HOME}/.krew/bin"
