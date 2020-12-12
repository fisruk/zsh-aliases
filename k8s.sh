# Merge multiple kubectl configuration files (see merged config by 'kubectl config view')
if [[ -d "${HOME}/.kube" ]]; then
	export KUBECONFIG=$KUBECONFIG
	for file in ${HOME}/.kube/*.config; 
		do export KUBECONFIG="${KUBECONFIG}:${file}"; 
	done;
fi

# Delay the initialization of the kubectl completion until first k (kubectl) call
function k() {
  source <(kubectl completion zsh)
  alias k=kubectl
  kubectl $@
}

# Get current context
alias k.context='k config current-context'
# List all contexts
alias k.context:list='k config get-contexts -o name | sed "s/^/  /;\|^  $(k.context)$|s/ /*/"'
alias k.context:ls=k.context:list
# Change current context
alias k.context:change='k config use-context "$(k.context:list | fzf -e | sed "s/^..//")"'

# Get current namespace
alias k.ns='k config get-contexts --no-headers "$(k.context)" | awk "{print \$5}" | sed "s/^$/default/"'
# List all namespaces
alias k.ns:list='k get -o name ns | sed "s|^.*/|  |;\|^  $(k.ns)$|s/ /*/"'
# Change current namespace
alias k.ns:change='k config set-context --current --namespace "$(k.ns:list | fzf -e | sed "s/^..//")"'
