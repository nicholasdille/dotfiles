#!/bin/bash

mkdir -p ~/.config/docker-hcloud
CONFIG_FILE=~/.config/docker-hcloud/config.sh
[[ -f "${CONFIG_FILE}" ]] && . ${CONFIG_FILE}

HCLOUD_VM_IP=$(hcloud server list --selector docker-hcloud=true --output columns=ipv4 | tail -n +2)
if [[ -z "${HCLOUD_VM_IP}" ]]; then
    HCLOUD_VM_NAME="${VM_BASE_NAME}-$(date +%Y%m%d%H%M)"
    hcloud server create \
        --location ${HCLOUD_LOCATION} \
        --image ${HCLOUD_IMAGE} \
        --name ${HCLOUD_VM_NAME} \
        --ssh-key ${HCLOUD_SSH_KEY} \
        --type ${HCLOUD_TYPE} \
        --user-data-from-file ~/.config/docker-hcloud/docker-user-data.txt
    hcloud server add-label ${HCLOUD_VM_NAME} docker-hcloud=true
    HCLOUD_VM_IP=$(hcloud server list --output columns=ipv4,name | grep docker-${HCLOUD_DOCKER_VM_NAME} | cut -d' ' -f1)
fi

# Creating SSH config
cat >~/.ssh/config.d/docker-hcloud <<EOF
Host ${HCLOUD_VM_IP}
    HostName ${HCLOUD_VM_IP}
    User root
    IdentityFile ~/id_rsa_hetzner
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
chmod 0600 ~/.ssh/config.d/docker-hcloud

# Wait for dockerd
echo Waiting for dockerd...
timeout 300 bash -c "while test -z '$(ssh ${HCLOUD_VM_IP} ps -C dockerd --no-headers)'; do sleep 2; done"
export DOCKER_HOST=ssh://${HCLOUD_VM_IP}
