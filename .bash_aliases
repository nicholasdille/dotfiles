alias gs="git status -s"
alias gd="git diff"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -m"
alias gac="git add --all && git commit -m"
alias gpsh="git push"
alias gpll="git pull"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cs="config status -s"
alias ca="config add"
alias cc="config commit -m"
alias cpsh="config push"
alias cpll="config pull"

alias kga="kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found"
