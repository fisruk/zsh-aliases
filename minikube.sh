#—————————————————————————————————————————————————————————————————————————————————#
# Delay the initialization of the minikube completion until first k (kubectl) call
#—————————————————————————————————————————————————————————————————————————————————#
function mk() {
  alias mk=minikube

  minikube $@
}

# Use minikube's built-in docker daemon
alias mk.dd:set="eval $(minikube docker-env)"
# Use local docker deamon (brew install docker-machine)
alias mk.dd:revert="eval $(docker-machine env -u)"
