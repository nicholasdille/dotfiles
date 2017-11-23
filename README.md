# Installation

```
git clone --bare https://github.com/nicholasdille/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
#echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

# Prerequisites

## System

### Linux

```
sudo apt install build-essential fontconfig
sudo apt install python-pip powerline-status
```

### WSL

Install [wsl-terminal](https://github.com/goreliu/wsl-terminal) following these [instructions](https://github.com/goreliu/wsl-terminal#usage) and install at least one of the [NerdFonts](https://github.com/ryanoasis/nerd-fonts)

## User

### Fonts

```
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf /usr/share/fonts/
fc-cache -vf /usr/share/fonts/
mv 10-powerline-symbols.conf /etc/fonts/conf.d/
```

### bash

Add the following to `.bashrc`:

```
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
```

Maybe the above only works for certain values of `TERM`, e.g. `export TERM=xterm`.

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

### ssh-agent

I consider WSL to be a tool but my Windows is authorative. Therefore, my KeePass2 is responsible for storing SSH private keys and providing an SSH agent. Using [this guide](https://solariz.de/de/ubuntu-subsystem-windows-keepass-keeagent-pageant-linux-ssh.htm), I was able to implement this requirement. It relies on [weasel-pageant](https://github.com/vuori/weasel-pageant).

### dircolors

Colors are seriously mangled in WSL. A solution for this is:

```
git clone https://github.com/seebi/dircolors-solarized
eval $(dircolors dircolors-solarized/dircolors.256dark)
```
