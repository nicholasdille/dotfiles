# dotfiles

This repository contains my dotfiles. Please mind that my dotfiles are strongly opinionated.

## Installation

The following commands create a checkout in your home directory. For this, a detached head is used with the `.git` directory stored in `~/.cfg`.

```bash
git clone --bare https://github.com/nicholasdille/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
rm ~/.bash_logout ~/.bashrc ~/.profile
config checkout
```

As soon as you start a login shell for the first time, you will see the first launch setup.

## Windows Subsystem for Linux (WSL)

To create a new distribution, download a root filesystem, e.g. [Ubuntu Hirsute](https://cloud-images.ubuntu.com/hirsute/current/), then import it using `wsl.exe --import my_name c:\wsl\ubuntu ~\Downloads\hirsute-server-cloudimg-amd64-wsl.rootfs.tar.gz`. Afterwards set a username as documented [here](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#user).

For pretty prompts (based on powerline) you need to install a proper terminal emulator and fonts. I recommend the [Windows Terminal](https://github.com/microsoft/terminal/releases) with [Cascadia Code](https://github.com/microsoft/cascadia-code).

## Linux native

### Visual Studio Code

```shell
uniget install vscode-cli
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
```

Or maybe install directly from `https://update.code.visualstudio.com/{version}/linux-x64/stable`

### KeePassXC

```shell
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt update
sudo apt install keepassxc
```

### Firefox

```shell
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A6DCF7707EBC211F
sudo apt-add-repository "deb http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu focal main"
sudo apt update
sudo apt install firefox
``` 

Or maybe download directly from `https://download-installer.cdn.mozilla.net/pub/firefox/releases/{version}/linux-x86_64/en-US/firefox-{version}.tar.bz2`

Find latest version:

```shell
curl -fI 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' | grep -o 'firefox-[0-9.]\+[0-9]
```

### Tabby

See [homepage](https://tabby.sh/)

Update from [releases](https://github.com/Eugeny/tabby/releases)

### Cryptomator

```shell
sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
sudo apt update
sudo apt install cryptomator
```
