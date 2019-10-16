alias dr.r:gitlab-runner='docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner:latest'
alias dr.r:portainer='docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" -p 9000:9000 portainer/portainer; echo "\nhttp://0.0.0.0:9000\n"'
alias dr.db:start="docker run -d --rm --name db --network host -p 3306:3306 -v ~/Projects/_global/docker/mysql/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d:ro -e MYSQL_ROOT_PASSWORD=root -d mariadb:10.4.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci"
alias dr.pma:st="docker run -d --rm --name pma --network host -e PMA_HOST=docker.for.mac.host.internal -p 1010:80 phpmyadmin/phpmyadmin"
alias dr.pma:sp="docker stop pma"
alias dr.mc:st="docker run -d --rm --name mailcatcher --network host -p 1020:1080 -p 1025:1025 schickling/mailcatcher"
alias dr.mc:sp="docker stop mailcatcher"
alias dr.sftp:st="docker run -d -P --rm --name sftp --network host -v ~/Projects/_global/docker/sftp/data/incoming:/data/incoming writl/sftp"
alias dr.stfp.sp="docker stop sftp"
alias dr.local-dev:start="dr.db:start; dr.pma:start; dr.mc:start"
