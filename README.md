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

## Windows Subsystem for Linux (WSL)

To create a new distribution, download a root filesystem, e.g. [Ubuntu Hirsute](https://cloud-images.ubuntu.com/hirsute/current/), then import it using `wsl.exe --import my_name c:\wsl\ubuntu ~\Downloads\hirsute-server-cloudimg-amd64-wsl.rootfs.tar.gz`. Afterwards set a username as documented [here](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#user).

For pretty prompts (based on powerline) you need to install a proper terminal emulator and fonts. I recommend the [Windows Terminal](https://github.com/microsoft/terminal/releases) with [Cascadia Code](https://github.com/microsoft/cascadia-code).

## Linux native

### git

```shell
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```

### Visual Studio Code

Follow the [official documentation](https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions)

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

### Cryptomator

```shell
sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
sudo apt update
sudo apt install cryptomator
```

### Hibernate

1. Disable Secure Boot
1. Swap partition with minimum size of RAM
1. Encrypted swap is highly recommended
1. If you are using LUKS and LVM but your swap partition is too small:

    ```shell
    lvresize -L -50GB --resizefs /dev/mapper/vgzorin-root
    lvresize -L +50GB /dev/mapper/vgzorin-swap_1
    mkswap /dev/mapper/vgzorin-swap_1
    ```

1. Modify `/etc/default/grub` so that `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=/dev/mapper/vgzorin-swap_1"`
1. Create `/etc/initramfs-tools/conf.d/resume` with content: `RESUME=/dev/mapper/vgzorin-swap_1`
1. Test hibernation as superuser: `sudo systemctl hibernate`
1. Create a policy in `/etc/polkit-1/rules.d/hibernate.rules` to allow hibernate by users:

    ```plaintext
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.hibernate" ||
            action.id == "org.freedesktop.login1.hibernate-multiple-sessions" ||
            action.id == "org.freedesktop.upower.hibernate" ||
            action.id == "org.freedesktop.login1.handle-hibernate-key" ||
            action.id == "org.freedesktop.login1.hibernate-ignore-inhibit") {
            return polkit.Result.YES;
        }
    });
    ```

1. Test hibernation as user: `systemctl hibernate`
1. Install [Hibernate Status Button](https://extensions.gnome.org/extension/755/hibernate-status-button/)
