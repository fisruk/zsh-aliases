alias g="git"

# Source library functions
source ~/.aliases/lib/git.sh
source ~/.aliases/lib/ui.sh

# Git branch creation with fuzzy finder
g.branch:new() {
    git.check_repo || { echo "Error: Not in a git repository"; return 1; }
    
    local base_branch
    base_branch=$(g.branch:select_base) || { echo "Abgebrochen"; return 0; }
    
    if [[ "$base_branch" == ERROR:* ]]; then
        echo "${base_branch#ERROR: }"
        return 1
    fi
    
    g.branch:check_status "$base_branch" || { echo "Abgebrochen"; return 0; }
    
    local new_branch
    new_branch=$(g.branch:get_name) || { echo "Kein Branch Name angegeben"; return 1; }
    
    git checkout -b "$new_branch" "$base_branch"
}

g.branch:select_base() {
    local default_branch=$(git.get_default_branch)
    local options
    
    if [ -n "$default_branch" ]; then
        options="$default_branch\nAnderen Branch"
    else
        options="main/master (nicht gefunden)\nAnderen Branch"
    fi
    
    local choice=$(ui.select_with_exit "Neuer Branch von: " "$options")
    
    case "$choice" in
        "")
            return 1
            ;;
        "$default_branch")
            echo "$default_branch"
            ;;
        "main/master (nicht gefunden)")
            echo "ERROR: Weder main noch master Branch gefunden"
            return 1
            ;;
        *)
            local branches=$(git.get_all_branches)
            local selected=$(ui.select_option "Wähle Base Branch: " "$branches")
            if [ -z "$selected" ]; then
                return 1
            fi
            echo "$selected"
            ;;
    esac
}

g.branch:check_status() {
    local base_branch="$1"
    
    # Check uncommitted changes
    if ! git.check_uncommitted_changes; then
        local choice=$(ui.select_option "Uncommitted changes gefunden: " "Trotzdem fortfahren\nAbbrechen")
        [ "$choice" != "Trotzdem fortfahren" ] && return 1
    fi
    
    # Check remote updates
    if ! git.check_remote_updates "$base_branch"; then
        ui.select_branch_action "$base_branch"
        local action=$?
        
        case $action in
            0) git.update_branch "$base_branch" ;;
            1) echo "Fortfahren ohne Update..." ;;
            2) return 1 ;;
        esac
    fi
}

g.branch:get_name() {
    local prefix=$(ui.select_option "Branch Prefix: " "feature/TOFU-\nbug/TOFU-\nhotfix/TOFU-\nCustom")
    
    [ -z "$prefix" ] && return 1
    
    if [[ "$prefix" == "Custom" ]]; then
        ui.read_input "Kompletter Branch Name: "
    else
        local suffix=$(ui.read_input "Branch Suffix (${prefix}...): ")
        [ -z "$suffix" ] && return 1
        echo "${prefix}${suffix}"
    fi
}

alias e="nvim"
alias p='cd "$(find ~/Documents/Projekte/* -type d -maxdepth 1 | fzf -e -d "/" --with-nth 6,7,8)"'
alias py="python3"
alias cat="bat --theme=Dracula --color=always --line-range=:500  --style=numbers"

# https://the.exa.website/docs
alias l="eza"
alias ll="eza --long --hyperlink --header --all"
alias tree='eza --long --tree --hyperlink --header --all'

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


# Problem: "Error: ENFILE: file table overflow"
# See:  https://gist.github.com/tombigel/d503800a282fcadbee14b537735d202c
alias increase-open-file-limit="sudo launchctl limit maxfiles 1048576"
