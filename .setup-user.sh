#!/bin/bash
set -e

source ~/.setup-vars.sh

mkdir -p ${TARGET} ~/.bash_completion.d
export PATH=$HOME/.local/bin:$PATH

# Docker
if ! type docker 2>/dev/null; then
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
fi

# Rancher CLI
if ! type rancher 2>/dev/null; then
    echo
    echo Installing Rancher CLI
    RANCHER_CLI_VERSION=0.6.12
    echo - Version: ${RANCHER_VERSION}
    curl -sL https://github.com/rancher/cli/releases/download/v${RANCHER_CLI_VERSION}/rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz | tar -xz -C ${TARGET} --strip-components=2
    echo - Done.
fi

# docker-compose
if ! type docker-compose 2>/dev/null; then
    echo
    echo Installing docker-compose
    DOCKER_COMPOSE_VERSION=1.23.1
    echo - Version: ${DOCKER_COMPOSE_VERSION}
    wget -O ${TARGET}/docker-compose https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64
    chmod +x ${TARGET}/docker-compose
    curl -sL https://github.com/docker/compose/raw/${DOCKER_COMPOSE_VERSION}/contrib/completion/bash/docker-compose > ~/.bash_completion.d/docker-compose
    echo - Done.
fi

# docker-machine
if ! type docker-machine 2>/dev/null; then
    echo
    echo Installing docker-machine
    DOCKER_MACHINE_VERSION=0.16.0
    echo - Version: ${DOCKER_MACHINE_VERSION}
    wget -O ${TARGET}/docker-machine https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64
    chmod +x ${TARGET}/docker-machine
    echo - Done.
fi

# docker-app
if ! type docker-app 2>/dev/null; then
    echo
    echo Installing docker-app
    DOCKER_APP_VERSION=0.6.0
    echo - Version: ${DOCKER_APP_VERSION}
    curl -sL https://github.com/docker/app/releases/download/v${DOCKER_APP_VERSION}/docker-app-linux.tar.gz | tar -xz -C ${TARGET}
    mv ${TARGET}/docker-app-linux ${TARGET}/docker-app
    echo - Done.
fi

# jq
if ! type jq 2>/dev/null; then
    echo
    echo Installing jq
    JQ_VERSION=1.6
    echo - Version: ${VERSION}
    wget -O ${TARGET}/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64
    chmod +x ${TARGET}/jq
    echo - Done.
fi

# docker-ls / docker-rm
if ! type docker-ls docker-rm 2>/dev/null; then
    echo
    echo Installing docker-ls/docker-rm
    DOCKER_LS_VERSION=0.3.2
    echo - Version: ${DOCKER_LS_VERSION}
    wget https://github.com/mayflower/docker-ls/releases/download/v${DOCKER_LS_VERSION}/docker-ls-linux-amd64.zip
    unzip -d ${TARGET} docker-ls-linux-amd64.zip
    rm docker-ls-linux-amd64.zip
    echo - Done.
fi

# kubectl
if ! type kubectl 2>/dev/null; then
    echo
    echo Installing kubectl
    KUBECTL_VERSION=1.12.2
    echo - Version: ${KUBECTL_VERSION}
    wget -O ${TARGET}/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
    chmod +x ${TARGET}/kubectl
    kubectl completion bash > ~/.bash_completion.d/kubectl
    echo - Done.
fi

# hub
if ! type hub 2>/dev/null; then
    echo
    echo Installing hub
    HUB_VERSION=2.6.0
    echo - Version: ${HUB_VERSION}
    curl -sL https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar -xz -C ~/.local --strip-components=1 --wildcards hub-linux-amd64-${HUB_VERSION}/bin/* hub-linux-amd64-${HUB_VERSION}/share/* hub-linux-amd64-${HUB_VERSION}/etc/hub.bash_completion.sh
    mv ~/.local/etc/hub.bash_completion.sh ~/.bash_completion.d/hub
    echo - Done.
fi
