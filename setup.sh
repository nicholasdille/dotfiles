#!/bin/bash
set -e

# Rancher CLI
RANCHER_CLI_VERION=0.6.12
curl -sL https://github.com/rancher/cli/releases/download/v${RANCHER_CLI_VERSION}/rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz | tar -xz -C ~/.local/bin --strip-components=2

# docker-compose
DOCKER_COMPOSE_VERSION=1.23.1
curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 > ~/.local/bin/docker-compose
chmod +x ~/.local/bin/docker-compose

# docker-machine
DOCKER_MACHINE_VERSION=0.16.0
curl -sL https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64 > ~/.local/bin/docker-machine
chmod +x ~/.local/bin/docker-machine

# jq
#

# docker-ls / docker-rm
#DOCKER_LS_VERSION=0.3.2
#wget https://github.com/mayflower/docker-ls/releases/download/v${DOCKER_LS_VERSION}/docker-ls-linux-amd64.zip
