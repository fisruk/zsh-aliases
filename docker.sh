# Execute command or enter a running Docker container.
function d.e() {
   if [[ ! "$1" ]] ; then
     echo "You must supply a container ID or name."
     return 0
   fi

   if [[ ! "$2" ]] ; then
      docker exec -it $1 bash
     return 0
   fi

   docker exec -it $1 $2
   return 0
}

alias d="docker"
alias d.i="docker images"
alias d.l="docker logs"
alias d.ps='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}"'
alias d.ps.service='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}" --filter "name=^service*" | sort'
alias d.ps.portal='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}" --filter "name=^portal*" | sort'
alias d.ps.sync='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}" --filter "name=^sync-*" | sort'
alias d.ps:a="docker ps -a"
alias d.sp="docker stop"
alias d.r="docker run"
alias d.rm="docker rm"
alias d.rm.all='d-stop-all; docker rm $(docker ps -a -q)'
alias d.rmi="docker rmi"
alias d.rmi.untagged='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'alias d.sp.all='docker stop $(docker ps -q)'

# misc helpers
alias d.r:gitlab-runner='docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner:latest'
alias d.r:portainer='docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" -p 9000:9000 portainer/portainer; echo "\nhttp://0.0.0.0:9000\n"'
