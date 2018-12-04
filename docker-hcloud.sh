#!/bin/bash

mkdir -p ~/.config/docker-hcloud
CONFIG_FILE=~/.config/docker-hcloud/vm

if test -f "${CONFIG_FILE}"; then
    source "${CONFIG_FILE}"
else
    HCLOUD_DOCKER_VM_NAME=$(date +"%Y%m%d%H%M")
    hcloud server create --location fsn1 --image ubuntu-18.04 --name docker-${HCLOUD_DOCKER_VM_NAME} --ssh-key 209622 --type cx11 --user-data-from-file ~/.config/docker-hcloud/docker-user-data.txt
    HCLOUD_DOCKER_VM_IP=$(hcloud server list --output columns=ipv4,name | grep docker-${HCLOUD_DOCKER_VM_NAME} | cut -d' ' -f1)

    cat >~/.config/docker-hcloud/vm <<EOF
    HCLOUD_DOCKER_VM_NAME=${HCLOUD_DOCKER_VM_NAME}
    HCLOUD_DOCKER_VM_IP=${HCLOUD_DOCKER_VM_IP}
EOF
fi

echo "Docker is being installed:"
timeout 300 bash -c "while test -z '$(ssh -i id_rsa_hetzner root@${HCLOUD_DOCKER_VM_IP} ps -C dockerd --no-headers)'; do echo Waiting...; sleep 10; done"
if test -z "$?"; then
    export DOCKER_HOST=ssh://root@${HCLOUD_DOCKER_VM_IP}
    echo Done.
fi
