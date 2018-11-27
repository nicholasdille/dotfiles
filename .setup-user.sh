#!/bin/bash
set -e

TARGET=~/.local/bin
mkdir -p ${TARGET} ~/.bash_completion.d
export PATH=$HOME/.local/bin:$PATH

# Docker
echo
echo Installing Docker
DOCKER_RELEASE=$(curl -s https://api.github.com/repos/docker/docker-ce/releases/latest)
DOCKER_VERSION=$(echo "${DOCKER_RELEASE}" | jq --raw-output '.name')
DOCKER_BRANCH=$(echo "${DOCKER_RELEASE}" | jq --raw-output '.target_commitish')
echo - Version: ${DOCKER_VERSION}
echo - Branch : ${DOCKER_BRANCH}
curl -sL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar -xvz -C ${TARGET} --strip-components=1
curl -sL https://github.com/docker/cli/raw/${DOCKER_BRANCH}/contrib/completion/bash/docker > ~/.bash_completion.d/docker
echo - Done.

# Rancher CLI
echo
echo Installing Rancher CLI
if ! type rancher >/dev/null; then
    RANCHER_CLI_VERSION=0.6.12
    echo - Version: ${RANCHER_VERSION}
    curl -sL https://github.com/rancher/cli/releases/download/v${RANCHER_CLI_VERSION}/rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz | tar -xz -C ${TARGET} --strip-components=2
fi
echo - Done.

# docker-compose
echo
echo Installing docker-compose
if ! type docker-compose >/dev/null; then
    DOCKER_COMPOSE_VERSION=1.23.1
    echo - Version: ${DOCKER_COMPOSE_VERSION}
    wget -O ${TARGET}/docker-compose https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64
    chmod +x ${TARGET}/docker-compose
    curl -sL https://github.com/docker/compose/raw/${DOCKER_COMPOSE_VERSION}/contrib/completion/bash/docker-compose > ~/.bash_completion.d/docker-compose
fi
echo - Done.

# docker-machine
echo
echo Installing docker-machine
if ! type docker-machine >/dev/null; then
    DOCKER_MACHINE_VERSION=0.16.0
    echo - Version: ${DOCKER_MACHINE_VERSION}
    wget -O ${TARGET}/docker-machine https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64
    chmod +x ${TARGET}/docker-machine
fi
echo - Done.

# jq
echo
echo Installing jq
if ! type jq >/dev/null; then
    JQ_VERSION=1.6
    echo - Version: ${VERSION}
    wget -O ${TARGET}/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64
    chmod +x ${TARGET}/jq
fi
echo - Done.

# docker-ls / docker-rm
echo
echo Installing docker-ls/docker-rm
if ! type docker-ls docker-rm >/dev/null; then
    DOCKER_LS_VERSION=0.3.2
    echo - Version: ${DOCKER_LS_VERSION}
    wget https://github.com/mayflower/docker-ls/releases/download/v${DOCKER_LS_VERSION}/docker-ls-linux-amd64.zip
    unzip -d ${TARGET} docker-ls-linux-amd64.zip
    rm docker-ls-linux-amd64.zip
fi
echo - Done.

# kubectl
echo
echo Installing kubectl
if ! type kubectl >/dev/null; then
    KUBECTL_VERSION=1.12.2
    echo - Version: ${KUBECTL_VERSION}
    wget -O ${TARGET}/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
    chmod +x ${TARGET}/kubectl
    kubectl completion bash > ~/.bash_completion.d/kubectl
fi
echo - Done.
