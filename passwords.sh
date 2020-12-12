# WIP: human readable german password (pip install xkcdpass)
alias pw.create:hr="xkcdpass -w ger-anlx -n 2 -c 5"
# secure pw
alias pw.create:s="pwgen -s -n 20 -N 1 -c -B -v"
# super secure pw
alias pw.create:ss="pwgen -s -n 30 -N 1 -c -y"
# super secure pw
alias pw.create:sss="pwgen -s -n 60 -N 1 -c -y"