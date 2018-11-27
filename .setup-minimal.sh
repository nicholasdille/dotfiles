#!/bin/bash
set -e

source ~/.setup-vars.sh

# powerline
#sudo apt-get update
#sudo apt-get -y install \
#    python-pip
#sudo pip install --upgrade \
#    powerline-status \
#    powerline-gitstatus

# pureline
#TEMP_NAME=$(basename $(mktemp --dry-run))
#git clone https://github.com/chris-marsh/pureline.git ${TEMP_NAME}
#cp ${TEMP_NAME}/pureline ${TARGET}
#rm -rf ${TEMP_NAME}

# powerline-go
POWERLINE_GO_VERSION=1.11.0
curl -sLO https://github.com/justjanne/powerline-go/releases/download/v${POWERLINE_GO_VERSION}/powerline-go-linux-amd64
chmod +x powerline-go-linux-amd64
mv powerline-go-linux-amd64 ${TARGET}/powerline-go
