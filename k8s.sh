#—————————————————————————————————————————————————————————————————————————————————#
# Merge multiple kubectl configuration files 
# View merged config by running 'kubectl config view' command.
#—————————————————————————————————————————————————————————————————————————————————#
if [[ -d "${HOME}/.kube" ]]; then
	export KUBECONFIG=$KUBECONFIG
	for file in ${HOME}/.kube/config; 
		do export KUBECONFIG="${KUBECONFIG}:${file}"; 
	done;
fi

#—————————————————————————————————————————————————————————————————————————————————# 
# Delay the initialization of the kubectl completion until first k (kubectl) call
#—————————————————————————————————————————————————————————————————————————————————#
function k() {
  	source <(kubectl completion zsh)

  	alias k=kubectl
  
  	kubectl $@
}

function k.e:bash() {
	k.e $@ -- /bin/bash
}

alias k.g="k get"
alias k.d="k describe"
alias k.rm="k delete"
alias k.l="k logs"
alias k.e="k exec --stdin --tty"
alias k.a="k apply -f"

alias k.failed-pods="k get pods --all-namespaces -l team=tofu --field-selector=status.phase=Failed"
alias k.ing-list="kubectl get ing -o=custom-columns='NAMESPACE:.metadata.namespace,INGRESS-NAME:.metadata.name,PATHs:..path'"
alias k.ing-list-all="kubectl get ing --all-namespaces -o=custom-columns='NAMESPACE:.metadata.namespace,INGRESS-NAME:.metadata.name,PATHs:..path'"

#———————————————————————————#
# Context
#———————————————————————————#
alias k.context='k config current-context'
# List all contexts
alias k.context:list='k config get-contexts -o name | sed "s/^/  /;\|^  $(k.context)$|s/ /*/"'
alias k.context:ls=k.context:list
# Change current context
alias k.context:change='k config use-context "$(k.context:list | fzf -e | sed "s/^..//")"'

#———————————————————————————#
# Namespaces
#———————————————————————————#
# Get current namespace
alias k.ns='k config get-contexts --no-headers "$(k.context)" | awk "{print \$5}" | sed "s/^$/default/"'
# List all namespaces
alias k.ns:list='k get -o name ns | sed "s|^.*/|  |;\|^  $(k.ns)$|s/ /*/"'
# Change current namespace
alias k.ns:change='k config set-context --current --namespace "$(k.ns:list | fzf -e | sed "s/^..//")"'
