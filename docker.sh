alias d="docker"
alias d.e="docker exec -it"
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