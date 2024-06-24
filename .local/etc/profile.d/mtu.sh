#!/bin/bash

if test -n "${WSL_DISTRO_NAME}" && test "${HOSTNAME:0:2}" == "HG"; then

    PATH="${PATH:+${PATH}:}/mnt/c/Windows/System32/WindowsPowerShell/v1.0"

    MIN_MTU="$(
        powershell.exe -command "Get-NetIPInterface | Select-Object -ExpandProperty NlMtu | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum" \
        | tr -d '\r'
    )"
    CUR_MTU="$(
        ip link show dev eth0 \
        | grep mtu \
        | cut -d' ' -f5
    )"

    if test "${CUR_MTU}" -ne "${MIN_MTU}"; then
        echo "Setting MTU on eth0  (${CUR_MTU} -> ${MIN_MTU}). Sudo required."
        sudo ip link set dev eth0 mtu ${MIN_MTU}
    fi

    DOCKER_MTU="$(
        ip link show dev docker0 \
        | grep mtu \
        | cut -d' ' -f5
    )"
    if test "${DOCKER_MTU}" -ne "${MIN_MTU}"; then
        echo "Fixing Docker MTU (${DOCKER_MTU} -> ${MIN_MTU}). Sudo required."
        sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
        sudo jq --arg mtu "${MIN_MTU}" '.mtu = ($mtu | tonumber) | ."network-control-plane-mtu" = ($mtu | tonumber) | ."default-network-opts".bridge."com.docker.network.driver.mtu" = $mtu' "/etc/docker/daemon.json.bak" | sudo tee "/etc/docker/daemon.json" >/dev/null

        if test "$(docker ps -q | wc -l)" -gt 0; then
            echo "Warning: Containers are running. New MTU will not take effect."
        fi

        echo "Restarting Docker. Sudo required."
        if systemctl >/dev/null 2>&1; then
            sudo systemctl restart docker
        else
            echo "Warning: SystemD not found. Please restart Docker manually."
        fi
    fi

fi
