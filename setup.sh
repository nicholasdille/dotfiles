#!/bin/bash
set -e

# Add repo for az
source /etc/lsb-release
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ ${DISTRIB_CODENAME} main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xBC528686B50D79E339D3721CEB3E94ADBE1229CF" | sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg add

# Add repo for Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install distro packages
sudo apt-get update
sudo apt-get -y install \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    unzip \
    wget \
    curl \
    pigz \
    tree \
    docker-ce \
    azure-cli \
    awscli

# Docker
curl -sL https://github.com/docker/cli/raw/18.09/contrib/completion/bash/docker | sudo tee ~/.bash_completion.d/docker >/dev/null

TARGET=~/.local/bin
mkdir -p ${TARGET}

# Rancher CLI
if ! type rancher >/dev/null; then
    RANCHER_CLI_VERSION=0.6.12
    curl -sL https://github.com/rancher/cli/releases/download/v${RANCHER_CLI_VERSION}/rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz | tar -xz -C ${TARGET} --strip-components=2
fi

# docker-compose
if ! type docker-compose >/dev/null; then
    DOCKER_COMPOSE_VERSION=1.23.1
    wget -O ${TARGET}/docker-compose https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64
    chmod +x ${TARGET}/docker-compose
    curl -sL https://github.com/docker/compose/blob/1.23.1/contrib/completion/bash/docker-compose > ~/.bash_completion.d/docker-compose
fi

# docker-machine
if ! type docker-machine >/dev/null; then
    DOCKER_MACHINE_VERSION=0.16.0
    wget -O ${TARGET}/docker-machine https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64
    chmod +x ${TARGET}/docker-machine
fi

# jq
if ! type jq >/dev/null; then
    JQ_VERSION=1.6
    wget -O ${TARGET}/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64
    chmod +x ${TARGET}/jq
fi

# docker-ls / docker-rm
if ! type docker-ls docker-rm >/dev/null; then
    DOCKER_LS_VERSION=0.3.2
    wget https://github.com/mayflower/docker-ls/releases/download/v${DOCKER_LS_VERSION}/docker-ls-linux-amd64.zip
    unzip -d ${TARGET} docker-ls-linux-amd64.zip
    rm docker-ls-linux-amd64.zip
fi

# kubectl
if ! type kubectl >/dev/null; then
    KUBECTL_VERSION=1.12.2
    wget -O ${TARGET}/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
    chmod +x ${TARGET}/kubectl
    kubectl completion bash > ~/.bash_completion.d/kubectl
fi
