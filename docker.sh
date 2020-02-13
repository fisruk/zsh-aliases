alias dr="docker"
alias dr.e="docker exec -it"
alias dr.i="docker images"
alias dr.l="docker logs"
alias dr.ps='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}"'
alias dr.ps.service='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}" --filter "name=^service*"'
alias dr.ps.portal='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}" --filter "name=^portal*"'
alias dr.ps.sync='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.ID}}" --filter "name=^sync-*"'
alias dr.ps:a="docker ps -a"
alias dr.sp="docker stop"
alias dr.r="docker run"
alias dr.rm="docker rm"
alias dr.rm.all='dr-stop-all; docker rm $(docker ps -a -q)'
alias dr.rmi="docker rmi"
alias dr.rmi.untagged='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'alias dr.sp.all='docker stop $(docker ps -q)'