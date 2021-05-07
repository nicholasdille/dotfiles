# dotfiles

This repository contains my dotfiles. Please mind that my dotfiles are strongly opinionated.

## Installation

The following commands create a checkout in your home directory. For this, a detached head is used with the `.git` directory stored in `~/.cfg`.

```bash
git clone --bare https://github.com/nicholasdille/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```

As soon as the dotfiles are checked out, you should make sure that all required packages are installed:

```bash
bash ~/.setup-minimal.sh
```

## Windows Subsystem for Linux (WSL)

To create a new distribution, download a root filesystem, e.g. [Ubuntu Hirsute](https://cloud-images.ubuntu.com/hirsute/current/), then import it using `wsl.exe --import my_name c:\wsl\ubuntu ~\Downloads\hirsute-server-cloudimg-amd64-wsl.rootfs.tar.gz`. Afterwards set a username as documented [here](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#user).

For pretty prompts (based on powerline) you need to install a proper terminal emulator and fonts. I recommend the [Windows Terminal](https://github.com/microsoft/terminal/releases) with [Cascadia Code](https://github.com/microsoft/cascadia-code).
