GOROOT=~/.local/go
if [[ -f $GOROOT/bin/go ]] && [[ -x $GOROOT/bin/go ]]; then
    export GOROOT=~/.local/go
    PATH=$GOROOT/bin:$PATH

else
    GOROOT=$(ls -d /usr/lib/go-* 2>/dev/null | sort -n | tail -n 1)
    if [[ -f $GOROOT/bin/go ]] && [[ -x $GOROOT/bin/go ]]; then
        export GOROOT
        PATH=$GOROOT/bin:$PATH

    else
        unset GOROOT
    fi
fi
export GOPATH=$HOME/go
mkdir -p ${GOPATH}
PATH=$GOPATH/bin:${HOME}/.krew/bin:$PATH
