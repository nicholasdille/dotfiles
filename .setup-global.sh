#!/bin/bash
set -e

# Add repo for az
source /etc/lsb-release
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ ${DISTRIB_CODENAME} main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xBC528686B50D79E339D3721CEB3E94ADBE1229CF" | sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg add

# Add repo for Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Add repo for PowerShell Core
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# install distro packages
sudo apt-get update
sudo apt-get -y install \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    unzip \
    wget \
    curl \
    most \
    pigz \
    tree \
    powershell \
    azure-cli \
    awscli
