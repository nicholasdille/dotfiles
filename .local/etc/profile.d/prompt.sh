if type powerline-go >/dev/null 2>&1; then
    function _update_ps1() {
        PS1="$(echo -ne "\033]0;$(basename "${PWD}")\a"; powerline-go -theme ${HOME}/.local/etc/powerline-go-theme.json -error $? -modules exit,ssh,host,user,cwd,git,docker-context,kube,jobs -priority exit,ssh,host,user,cwd,jobs,git,kube,docker-context -newline -cwd-mode dironly -hostname-only-if-ssh)"
    }
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
else
    if ! test -f ~/.local/etc/git-prompt.sh; then
        mkdir -p ~/.local/etc
        git_version=$(git --version | cut -d' ' -f3)
        echo Installing git-prompt.sh v${git_version}
        curl -sLo ~/.local/etc/git-prompt.sh https://raw.githubusercontent.com/git/git/v${git_version}/contrib/completion/git-prompt.sh
    fi
    source ~/.local/etc/git-prompt.sh
    export GIT_PS1_SHOWCOLORHINTS=true
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    export PROMPT_COMMAND='__git_ps1 "\[\033[0;36m\]\u\[\033[0;35;40m\]@\h\[\033[0;37;0m\] \[\033[1;33m\]\W\[\033[0;37;0m\] [\j]" " \\\$ "'
fi

if [[ "${TERM_PROGRAM}" == "vscode" ]] || [[ "${ASCIINEMA_REC}" == "1" ]]; then
    PS1="\$ "
    unset PROMPT_COMMAND
fi
