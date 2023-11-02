#!/bin/bash

if test -n "${WSL_DISTRO_NAME}" && test "${HOSTNAME:0:2}" == "HG"; then

    if ! test -f /usr/local/share/ca-certificates/umbrella.crt; then
        PATH="${PATH:+${PATH}:}/mnt/c/Windows/System32/WindowsPowerShell/v1.0"

        sudo true
        powershell.exe -command "Get-ChildItem cert:\\LocalMachine\\Root | Where-Object {\$_.Subject -eq 'CN=Cisco Umbrella Root CA, O=Cisco'} | Export-Certificate -Type CERT -FilePath \\\\wsl\$\\${WSL_DISTRO_NAME}\\home\\${USER}\\umbrella.cer"

        if test -f "${HOME}/umbrella.cer"; then
            openssl x509 -in "${HOME}/umbrella.cer" -inform der -out "${HOME}/umbrella.pem" -outform pem
        fi

        if test -f "${HOME}/umbrella.pem"; then
            sudo cp "${HOME}/umbrella.pem" /usr/local/share/ca-certificates/umbrella.crt
            sudo update-ca-certificates
        fi

        rm -f "${HOME}/umbrella.{cer,pem}"
    fi

fi
