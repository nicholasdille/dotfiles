#!/bin/bash
set -x -e

TARGET=~/.local/bin

# Rancher CLI
if ! type rancher >/dev/null; then
    RANCHER_CLI_VERSION=0.6.12
    curl -sL https://github.com/rancher/cli/releases/download/v${RANCHER_CLI_VERSION}/rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz | tar -xz -C ${TARGET} --strip-components=2
fi

# docker-compose
if ! type docker-compose >/dev/null; then
    DOCKER_COMPOSE_VERSION=1.23.1
    curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 > ${TARGET}/docker-compose
    chmod +x ${TARGET}/docker-compose
fi

# docker-machine
if ! type docker-machine >/dev/null; then
    DOCKER_MACHINE_VERSION=0.16.0
    curl -sL https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64 > ${TARGET}/docker-machine
    chmod +x ${TARGET}/docker-machine
fi

# jq
if ! type jq >/dev/null; then
    JQ_VERSION=1.6
    curl -sL https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 > ${TARGET}/jq
    chmod +x ${TARGET}/jq
fi

# docker-ls / docker-rm
if ! type docker-ls docker-rm >/dev/null; then
    DOCKER_LS_VERSION=0.3.2
    wget https://github.com/mayflower/docker-ls/releases/download/v${DOCKER_LS_VERSION}/docker-ls-linux-amd64.zip
    unzip docker-ls-linux-amd64.zip
    rm docker-ls-linux-amd64.zip
    mv docker-{ls,rm} ~/.local/bin/
fi

# kubectl
if ! type kubectl >/dev/null; then
    KUBECTL_VERSION=1.12.2
    curl -sL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl > ${TARGET}/kubectl
    chmod +x ${TARGET}/kubectl
fi
