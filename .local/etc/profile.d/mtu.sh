#!/bin/bash

if test -n "${WSL_DISTRO_NAME}" && test "${HOSTNAME:0:2}" == "HG"; then

    PATH="${PATH:+${PATH}:}/mnt/c/Windows/System32/WindowsPowerShell/v1.0"

    sudo true
    MIN_MTU="$(
        powershell.exe -command "Get-NetIPInterface | Select-Object -ExpandProperty NlMtu | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum" \
        | tr -d '\r'
    )"
    echo "Got minimum MTU ${MIN_MTU}"
    sudo ip link set dev eth0 mtu ${MIN_MTU}

fi
