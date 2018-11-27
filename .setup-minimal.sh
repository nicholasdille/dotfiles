#!/bin/bash
set -e

# install distro packages
sudo apt-get update
sudo apt-get -y install \
    python-pip \

# Powerline
sudo pip install --upgrade \
    powerline-status \
    powerline-gitstatus
