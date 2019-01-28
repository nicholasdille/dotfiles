#!/bin/bash
set -e

rm -f ~/.ssh/config.d/hcloud_*
hcloud server list -o columns=name,ipv4 | tail -n +2 | while read LINE
do
    SERVER_NAME=$(echo $LINE | awk '{print $1}')
    SERVER_IP=$(echo $LINE | awk '{print $2}')

    cat > ~/.ssh/config.d/hcloud_${SERVER_NAME} <<EOF
Host ${SERVER_NAME} ${SERVER_IP}
    HostName ${SERVER_IP}
    User root
    IdentityFile ~/id_rsa_hetzner
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
    chmod 0640 ~/.ssh/config.d/hcloud_${SERVER_NAME}
done
