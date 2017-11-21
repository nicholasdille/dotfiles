# Installation

```
git clone --bare https://github.com/nicholasdille/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

# Prerequisites

## System

```
sudo apt install build-essentials
sudo apt install python-pip
sudo pip install powerline-status
```

## User

### Fonts

```
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
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
