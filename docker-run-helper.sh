alias d.r:gitlab-runner='docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner:latest'
alias d.r:portainer='docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" -p 9000:9000 portainer/portainer; echo "\nhttp://0.0.0.0:9000\n"'
alias d.db:st="docker run -d --rm --name db --network local-dev -p 3306:3306 -v ~/Projects/_global/docker/mysql/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d:ro -e MYSQL_ROOT_PASSWORD=root -d mariadb:10.4.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci"
alias d.db:sp="docker stop db"
alias d.pma:st="docker run -d --rm --name pma --network local-dev -e PMA_HOST=docker.for.mac.host.internal -p 1010:80 phpmyadmin/phpmyadmin"
alias d.pma:sp="docker stop pma"
alias d.mc:st="docker run -d --rm --name mailcatcher --network local-dev -p 1020:1080 -p 1025:1025 schickling/mailcatcher"
alias d.mc:sp="docker stop mailcatcher"
alias d.sftp:st="docker run -d -P --rm --name sftp --network local-dev -v ~/Projects/_global/docker/sftp/data/incoming:/data/incoming writl/sftp"
alias d.stfp.sp="docker stop sftp"
alias d.local-dev:start="d.db:start; d.pma:start; d.mc:start"
