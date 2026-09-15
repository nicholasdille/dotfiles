alias config-hg="git --git-dir=$HOME/.cfg-hg/ --work-tree=$HOME"
alias ch=config-hg
alias chs="ch status -s"
alias cha="ch add"
alias chc="ch commit -m"
alias chpsh="ch push"
alias chpll="ch pull"

#PASSAGE_IDENTITIES_FILE=~/.passage/haufe/identities PASSAGE_DIR=~/.passage/haufe/store PASSAGE_EXTENSIONS_DIR=~/.passage/haufe/extensions passage "$@"

if nslookup myfiles >/dev/null 2>&1; then
    if ! gio mount --list | grep -q smb://myfiles/dillen; then
        echo "### Mounting home share"
        gio mount smb://myfiles/dillen
    fi

    if ! gio mount --list | grep -q smb://myfiles/releaseeng; then
        echo "### Mounting team share"
        gio mount smb://myfiles/releaseeng
    fi
fi
