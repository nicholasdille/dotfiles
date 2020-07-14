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

For pretty prompts (based on powerline) you need to install a proper terminal emulator and fonts. I recommend the [Windows Terminal](https://github.com/microsoft/terminal/releases) with [Cascadia Code](https://github.com/microsoft/cascadia-code).

### SSH agent on WSL

I consider WSL to be a tool but my Windows is authorative. Therefore, my KeePass2 is responsible for storing SSH keys and providing an SSH agent (compatible to putty pageant). The following commands rely on [weasel-pageant](https://github.com/vuori/weasel-pageant) and install the binaries in `~\Documents\Apps\wsl-pageant\`:

```powershell
$WeaselPageantVersion = 1.1
Invoke-WebRequest -UseBasicParsing -Uri https://github.com/vuori/weasel-pageant/releases/download/v$WeaselPageantVersion/weasel-pageant-$WeaselPageantVersion.zip -OutFile "$env:temp\weasel-pageant-$WeaselPageantVersion.zip"
Unblock-File -Path "$env:temp\weasel-pageant-$WeaselPageantVersion.zip"
Expand-Archive -Path $env:temp\weasel-pageant-$WeaselPageantVersion.zip -DestinationPath ~\Documents\Apps
Rename-Item -Path ~\Documents\Apps\weasel-pageant-$WeaselPageantVersion -NewName ~\Documents\Apps\weasel-pageant
```

The connection to the SSH agent running on Windows is established by running `~/ssh-agent.sh` in WSL.
