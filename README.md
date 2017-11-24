# Installation

```
git clone --bare https://github.com/nicholasdille/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
#echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

## Prerequisites

### WSL

On Windows you need to install the Windows Subsystem for Linux (WSL) before installing the other prerequisites:

```powershell
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online
```

Unfortunately, you need to [install a distribution from the App Store manually](https://aka.ms/wslstore).

Install [wsl-terminal](https://github.com/goreliu/wsl-terminal) following these [instructions](https://github.com/goreliu/wsl-terminal#usage) and install at least one of the [NerdFonts](https://github.com/ryanoasis/nerd-fonts)

The following shows a useful command to launch a maximized window running a login shell in your Linux home directory.

```
%userprofile%\Documents\wsl-terminal\open-wsl.exe -C ~ -l -B "--window max --title WSL"
```

### Linux

The following commands are required to to install packages before setting up pretty prompts and status bars.


```bash
sudo apt install build-essential fontconfig
sudo apt install python-pip powerline-status
```

Some more commands to setup a proper font:

```bash
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf /usr/share/fonts/
fc-cache -vf /usr/share/fonts/
mv 10-powerline-symbols.conf /etc/fonts/conf.d/
```

## Enable pretty prompts

All commands displayed below are already integrated into my dotdiles.

### bash

Add the following to `.bashrc`:

```
export TERM=xterm-256color
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
```

### vim

Add the following to `.vimrc`:

```
set  rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256
```

### zsh

```
git clone https://github.com/bhilburn/powerlevel9k.git ~/powerlevel9k
echo 'source  ~/powerlevel9k/powerlevel9k.zsh-theme' >> ~/.zshrc
```

### tmux

Add the following to your `.tmux.conf`:

```
source '/usr/local/lib/python2.7/dist-packages/powerline/bindings/tmux/powerline.conf'
```

## SSH agent on WSL

I consider WSL to be a tool but my Windows is authorative. Therefore, my KeePass2 is responsible for storing SSH private keys and providing an SSH agent. Using [this guide](https://solariz.de/de/ubuntu-subsystem-windows-keepass-keeagent-pageant-linux-ssh.htm), I was able to implement this requirement. It relies on [weasel-pageant](https://github.com/vuori/weasel-pageant).

This is already integrated into my dotfiles.

## Fix dircolors

Colors are seriously mangled in WSL. A solution for this is:

```
git clone https://github.com/seebi/dircolors-solarized
eval $(dircolors dircolors-solarized/dircolors.256dark)
```

This is already integrated into my dotfiles.

## PowerShell

If you are planning to do something similar with PowerShell you need to use a terminal emulator, like [ConEmu](https://conemu.github.io/) or [Cmder](http://cmder.net/).

The following commands will get you started with a nice prompt:

```powershell
Install-Module -Name PowerLine
Import-Module -Name PowerLine
Set-PowerLinePrompt -SetCurrentDirectory -RestoreVirtualTerminal -Newline -Timestamp -Colors "#00DDFF","#0066FF"
```

If you are looking for theme management, take a look at [oh-my-posh](https://github.com/JanJoris/oh-my-posh):

```powershell
Import-Module -Name posh-git, oh-my-posh
Set-Theme agnoster
```

You should be using [fonts from here](https://github.com/gabrielelana/awesome-terminal-fonts).
