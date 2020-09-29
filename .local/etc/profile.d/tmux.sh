if [[ -z "${WSL_DISTRO_NAME}" && -z "${TMUX}" && "${TERM_PROGRAM}" != "vscode" ]]; then
    tmux ls | grep -vq attached && TMUXARG="attach-session -d"
    exec tmux -2 $TMUXARG
fi
