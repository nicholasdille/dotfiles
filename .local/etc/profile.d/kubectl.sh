KUBECONFIG_FILES=$(ls ~/.kube/{kube,}config.* 2>/dev/null)
export KUBECONFIG=~/.kube/config:$(echo ${KUBECONFIG_FILES} | tr ' ' ':')
alias k=kubectl
complete -F __start_kubectl k
