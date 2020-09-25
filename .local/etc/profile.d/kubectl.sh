export KUBECONFIG=~/.kube/config:$(ls ~/.kube/{kube,}config.* 2>/dev/null | tr '\n' ':')
alias k=kubectl
complete -F __start_kubectl k
