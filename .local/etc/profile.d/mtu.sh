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
        echo "Setting MTU to ${MIN_MTU}. Sudo required."
        sudo ip link set dev eth0 mtu ${MIN_MTU}
    fi

fi
