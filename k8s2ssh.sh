#!/bin/bash
set -o errexit

if [[ "$#" == 1 ]]; then
    CLUSTER=$1
fi
if [[ -z "${CLUSTER}" ]]; then
    CONTEXT=$(kubectl config current-context)
    CLUSTER=$(kubectl config get-contexts svc-2-admin | tail -n +2 | tr -s ' ' | cut -d' ' -f3)
fi
if [[ -z "${CLUSTER}" ]]; then
    echo Unable to determine cluster name
    kubectl config get-contexts
    exit 1
fi
echo "Found cluster name <${CLUSTER}>"

rm -f ~/.ssh/config.d/k8s_${CLUSTER}_*
kubectl get nodes -o wide | tail -n +2 | tr -s ' ' | while read LINE
do
    SERVER_NAME=$(echo $LINE | cut -d' ' -f1)
    SERVER_IP=$(echo $LINE | cut -d' ' -f6)

    cat > ~/.ssh/config.d/k8s_${CLUSTER}_${SERVER_NAME} <<EOF
Host ${SERVER_NAME} ${SERVER_IP}
    HostName ${SERVER_IP}
    User rdadm
    IdentityFile ~/id_rsa_rdadm
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
    chmod 0640 ~/.ssh/config.d/k8s_${CLUSTER}_${SERVER_NAME}
done
