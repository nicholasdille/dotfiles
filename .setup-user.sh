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

# hcloud
if ! type hcloud 2>/dev/null; then
    echo
    echo Installing hcloud
    HCLOUD_VERSION=1.10.0
    echo - Version: ${HCLOUD_VERSION}
    curl -sL https://github.com/hetznercloud/cli/releases/download/v${HCLOUD_VERSION}/hcloud-linux-amd64-v${HCLOUD_VERSION}.tar.gz | tar -xz -C ~/.local --strip-components=1 --wildcards hcloud-linux-amd64-v${HCLOUD_VERSION}/bin/* hcloud-linux-amd64-v${HCLOUD_VERSION}/etc/hcloud.bash_completion.sh
    mv ~/.local/etc/hcloud.bash_completion.sh ~/.bash_completion.d/hcloud
    echo - Done.
fi

# docker-machine driver for Hetzner Cloud
if ! type docker-machine-driver-hetzner 2>/dev/null; then
    echo
    echo Installing docker-machine-driver-hetzner
    DOCKER_MACHINE_DRIVER_HETZNER_VERSION=1.2.2
    echo - Version: ${DOCKER_MACHINE_DRIVER_HETZNER_VERSION}
    curl -sL https://github.com/JonasProgrammer/docker-machine-driver-hetzner/releases/download/${DOCKER_MACHINE_DRIVER_HETZNER_VERSION}/docker-machine-driver-hetzner_${DOCKER_MACHINE_DRIVER_HETZNER_VERSION}_linux_amd64.tar.gz | tar -xz -C ${TARGET}
    echo - Done.
fi

# tmux-xpanes
if ! type xpanes 2>/dev/null; then
    echo
    echo Installing tmux-xpanes
    TMUX_XPANES_VERSION=3.1.0
    echo - Version: ${TMUX_XPANES_VERSION}
    curl -sL https://github.com/greymd/tmux-xpanes/raw/v${TMUX_XPANES_VERSION}/bin/xpanes > ${TARGET}/xpanes
    chmod +x ${TARGET}/xpanes
    echo - Done.
fi

# kube-shell
#pip install kube-shell

# dive
#curl -sLf https://github.com/wagoodman/dive/releases/download/v0.6.0/dive_0.6.0_linux_amd64.tar.gz | tar -xvzC ~/.local/bin/ dive

# kubebox
#curl -sLf https://github.com/astefanutti/kubebox/releases/download/v0.4.0/kubebox-linux > ~/.local/bin/kubebox && chmod +x ~/.local/bin/kubebox

# k9s
#curl -sL https://github.com/derailed/k9s/releases/download/0.1.9/k9s_0.1.9_Linux_x86_64.tar.gz | tar -xvzC ~/.local/bin/ k9s

# dockly
#sudo apt install nodejs npm
#npm install dockly

# kubectx/kubens
#curl -sL https://github.com/ahmetb/kubectx/archive/v0.6.3.tar.gz | tar -xvz --strip-components=1 --wildcards kubectx-*/kubectx kubectx-*/kubens kubectx-*/completion/kubectx.bash kubectx-*/completion/kubens.bash && mv kubectx kubens ~/.local/bin/ && mv completion/*.bash ~/.local/etc/bash_completion.d/ && rmdir completion

# skopeo (local)
#sudo apt install golang libgpgme-dev libassuan-dev btrfs-progs libdevmapper-dev libostree-dev
#git clone https://github.com/containers/skopeo $GOPATH/src/github.com/containers/skopeo
#cd $GOPATH/src/github.com/containers/skopeo
#make binary-local

# skopeo (docker)
#make binary

# go-task
#curl -sL https://github.com/go-task/task/releases/download/v2.4.0/task_linux_amd64.tar.gz | tar -xvzC ~/.local/bin/ task

# k8sec
#curl -sL https://github.com/dtan4/k8sec/releases/download/v0.5.1/k8sec-v0.5.1-linux-amd64.tar.gz | tar -xvzC ~/.local/bin/ --strip-components=1 linux-amd64/k8sec

# rakkess
#curl -sL https://github.com/corneliusweig/rakkess/releases/download/v0.1.1/rakkess-linux-amd64.gz | gunzip > ~/.local/bin/rakkess && chmod +x ~/.local/bin/rakkess && rakkess completion bash > ~/.local/etc/bash_completion.d/rakkess

# umoci
#curl -sL https://github.com/openSUSE/umoci/releases/download/v0.4.4/umoci.amd64 >~/.local/bin/umoci && chmod +x ~/.local/bin/umoci

# img
#curl -sL https://github.com/genuinetools/img/releases/download/v0.5.6/img-linux-amd64 >~/.local/bin/img && chmod +x ~/.local/bin/img
