#!/bin/bash
set -e

source ~/.setup-vars.sh

# powerline-go
POWERLINE_GO_VERSION=1.11.0
curl -sLO https://github.com/justjanne/powerline-go/releases/download/v${POWERLINE_GO_VERSION}/powerline-go-linux-amd64
chmod +x powerline-go-linux-amd64
mv powerline-go-linux-amd64 ${TARGET}/powerline-go
