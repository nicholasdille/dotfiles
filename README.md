# Installation

```
git clone --bare https://github.com/nicholasdille/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```

## Prerequisites

### WSL only

On Windows you need to install the Windows Subsystem for Linux (WSL) before installing the other prerequisites:

```powershell
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online
```

After a reboot, you need to [install a distribution from the App Store manually](https://aka.ms/wslstore).

For pretty prompts you need to install a proper terminal emulator for WSL like [wsl-terminal](https://github.com/goreliu/wsl-terminal):

```powershell
$WslTerminVersion = '0.8.11'
$WslTerminalUrl = "https://github.com/goreliu/wsl-terminal/releases/download/v$WslTerminVersion/wsl-terminal-$WslTerminVersion.zip"
Invoke-WebRequest -UseBasicParsing -Uri $WslTerminalUrl -OutFile "$env:Temp\wsl-terminal.zip"
Unblock-File -Path "$env:Temp\wsl-terminal.zip"
Expand-Archive -Path "$env:Temp\wsl-terminal.zip" -DestinationPath "~\Documents\Apps"
```

The following commands install fonts required for pretty prompts:

```powershell
git clone https://github.com/powerline/fonts.git $env:Temp\fonts
cd $env:Temp\fonts
.\install.ps1
```

A nice way for opening a terminal is now:

```
%userprofile%\Documents\wsl-terminal\open-wsl.exe -C ~ -l -B "--window max"
```

After the first start of `open-wsl.exe`, configure a font and optionally choose a theme.

### Linux (including WSL)

Although many guide for PowerLine describe using `pip` to build and install it but I prefer using the binary package from the Ubuntu Universe repository:

```bash
sudo apt-get update
sudo apt-get install powerline
```

## SSH agent on WSL

I consider WSL to be a tool but my Windows is authorative. Therefore, my KeePass2 is responsible for storing SSH private keys and providing an SSH agent. The following commands rely on [weasel-pageant](https://github.com/vuori/weasel-pageant):

```powershell
$WeaselPageantVersion = 1.1
Invoke-WebRequest -UseBasicParsing -Uri https://github.com/vuori/weasel-pageant/releases/download/v$WeaselPageantVersion/weasel-pageant-$WeaselPageantVersion.zip -OutFile "$env:temp\weasel-pageant-$WeaselPageantVersion.zip"
Unblock-File -Path "$env:temp\weasel-pageant-$WeaselPageantVersion.zip"
Expand-Archive -Path $env:temp\weasel-pageant-$WeaselPageantVersion.zip -DestinationPath ~\Documents\Apps
Rename-Item -Path ~\Documents\Apps\weasel-pageant-$WeaselPageantVersion -NewName ~\Documents\Apps\weasel-pageant
```

This is already integrated into my dotfiles.
