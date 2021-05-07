#!/bin/bash

if test -z "${WSL_DISTRO_NAME}" && "${HOSTNAME:0:2}" == "HG"; then

    if ! test -f /usr/local/share/ca-certificates/umbrella.crt; then
        sudo true
        powershell.exe -command "Get-ChildItem cert:\\LocalMachine\\Root | Where-Object {\$_.Subject -eq 'CN=Cisco Umbrella Root CA, O=Cisco'} | Export-Certificate -Type CERT -FilePath \\\\wsl\$\\${WSL_DISTRO_NAME}\\home\\${USER}\\umbrella.cer"

        if test -f "${HOME}/umbrella.cer"; then
            openssl x509 -in "${HOME}/umbrella.cer" -inform der -out "${HOME}/umbrella.pem" -outform pem
        fi

        if test -f "${HOME}/umbrella.pem"; then
            sudo cp ~/umbrella.pem /usr/local/share/ca-certificates/umbrella.crt
            sudo update-ca-certificates
        fi

        rm -f umbrella.{cer,pem}
    fi

fi
