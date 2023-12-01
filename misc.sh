alias g="git"
alias p='cd "$(find ~/Documents/Projekte/* -type d -maxdepth 1 | fzf -e -d "/" --with-nth 6,7,8)"'
alias py="python3"
alias cat="bat --theme=Dracula --color=always --line-range=:500  --style=numbers"
alias l="exa"
alias ll="exa --long"
alias tree="exa --tree"

#—————————————————————————————————————————————————————————————————————————————————#
# MAC OS
#—————————————————————————————————————————————————————————————————————————————————#
alias dns.cache-clear="sudo killall -HUP mDNSResponder"

#—————————————————————————————————————————————————————————————————————————————————#
# RASPBERRY PI
#—————————————————————————————————————————————————————————————————————————————————#
alias cpu.temperature="sudo powermetrics --samplers smc |grep -i 'CPU die temperature'"
alias fan.speed="sudo powermetrics --samplers smc |grep -i 'Fan: '"

#—————————————————————————————————————————————————————————————————————————————————#
# PASSWORDS
#—————————————————————————————————————————————————————————————————————————————————#
# WIP: human readable german password (pip install xkcdpass)
alias pw.create:hr="xkcdpass -w ger-anlx --numwords=2 --count=10 --delimiter='_' --case=as-is | sed -e 's/[oO]/0/g; s/[sS]/$/g; s/[lL]/1/g; s/[eE]/3/g'"
# secure pw
alias pw.create:s="pwgen -s -n 20 -N 1 -c -B -v"
# super secure pw
alias pw.create:ss="pwgen -s -n 30 -N 1 -c -y"
# super secure pw
alias pw.create:sss="pwgen -s -n 60 -N 1 -c -y"