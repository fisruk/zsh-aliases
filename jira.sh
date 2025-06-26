#!/bin/bash
# Jira CLI aliases and utilities

# Source library functions
source ~/.aliases/lib/ui.sh

# Main Jira alias
alias j="jira"

# Jira configuration and setup
j.setup() {
    echo "Jira CLI Setup"
    echo "=============="
    echo ""
    echo "Um Jira CLI zu konfigurieren, führe aus:"
    echo "  jira init"
    echo ""
    echo "Du benötigst:"
    echo "- Jira Server URL (z.B. https://company.atlassian.net)"
    echo "- Email-Adresse"
    echo "- API Token (erstelle eins unter: Jira Settings > Security > API tokens)"
    echo ""
    echo "Nach der Konfiguration kannst du folgende Aliases verwenden:"
    echo "  j.ticket:search    - Tickets durchsuchen"
    echo "  j.ticket:open      - Ticket im Browser öffnen"
    echo "  j.ticket:new       - Neues Ticket erstellen"
    echo "  j.my              - Meine zugewiesenen Tickets"
    echo "  j.board           - Board anzeigen"
}

# Ticket search with fzf integration
j.ticket:search() {
    local project_key=$(j.project:select)
    [ -z "$project_key" ] && return 1
    
    # Get all issues for project and let user select with fzf
    local issues=$(jira issue list --project="$project_key" --plain --columns="key,summary,status,assignee" --no-headers)
    
    if [ -z "$issues" ]; then
        echo "Keine Issues im Projekt $project_key gefunden"
        return 1
    fi
    
    local selected=$(echo "$issues" | fzf --prompt="Wähle Issue: " --preview="jira issue view {1}")
    
    if [ -n "$selected" ]; then
        local issue_key=$(echo "$selected" | awk '{print $1}')
        j.ticket:show "$issue_key"
    fi
}

# Show specific ticket
j.ticket:show() {
    local issue_key="$1"
    
    if [ -z "$issue_key" ]; then
        echo "Issue Key benötigt: j.ticket:show PROJ-123"
        return 1
    fi
    
    jira issue view "$issue_key"
}

# Open ticket in browser
j.ticket:open() {
    local issue_key="$1"
    
    if [ -z "$issue_key" ]; then
        # Let user search and select
        local project_key=$(j.project:select)
        [ -z "$project_key" ] && return 1
        
        local issues=$(jira issue list --project="$project_key" --plain --columns="key,summary" --no-headers)
        local selected=$(echo "$issues" | fzf --prompt="Öffne Issue: ")
        
        if [ -n "$selected" ]; then
            issue_key=$(echo "$selected" | awk '{print $1}')
        fi
    fi
    
    if [ -n "$issue_key" ]; then
        jira open "$issue_key"
    fi
}

# Create new ticket
j.ticket:new() {
    local project_key=$(j.project:select)
    [ -z "$project_key" ] && return 1
    
    echo "Erstelle neues Ticket in Projekt: $project_key"
    jira issue create --project="$project_key"
}

# Show my assigned tickets
j.my() {
    local action=$(ui.select_option "Meine Tickets: " "Zugewiesene Issues\nIssues die ich erstellt habe\nIssues die ich beobachte")
    
    case "$action" in
        "Zugewiesene Issues")
            jira issue list --assignee="$(jira me)" --plain
            ;;
        "Issues die ich erstellt habe")
            jira issue list --reporter="$(jira me)" --plain
            ;;
        "Issues die ich beobachte")
            jira issue list --watcher="$(jira me)" --plain
            ;;
    esac
}

# Project selection helper
j.project:select() {
    local projects=$(jira project list --plain --columns="key,name" --no-headers 2>/dev/null)
    
    if [ -z "$projects" ]; then
        echo "Keine Projekte gefunden. Konfiguration prüfen mit: jira init"
        return 1
    fi
    
    local selected=$(echo "$projects" | fzf --prompt="Wähle Projekt: ")
    
    if [ -n "$selected" ]; then
        echo "$selected" | awk '{print $1}'
    fi
}

# Board management
j.board() {
    local project_key=$(j.project:select)
    [ -z "$project_key" ] && return 1
    
    echo "Lade Boards für Projekt: $project_key"
    jira board list --project="$project_key"
}

# Sprint management  
j.sprint() {
    local project_key=$(j.project:select)
    [ -z "$project_key" ] && return 1
    
    local action=$(ui.select_option "Sprint Aktion: " "Aktuelle Sprints\nAlle Sprints\nSprint Details")
    
    case "$action" in
        "Aktuelle Sprints")
            jira sprint list --project="$project_key" --state="active"
            ;;
        "Alle Sprints")
            jira sprint list --project="$project_key"
            ;;
        "Sprint Details")
            local sprints=$(jira sprint list --project="$project_key" --plain --columns="id,name,state" --no-headers)
            local selected=$(echo "$sprints" | fzf --prompt="Wähle Sprint: ")
            
            if [ -n "$selected" ]; then
                local sprint_id=$(echo "$selected" | awk '{print $1}')
                jira sprint view "$sprint_id"
            fi
            ;;
    esac
}

# Quick search across all projects
j.search() {
    local query=$(ui.read_input "Suchbegriff: ")
    [ -z "$query" ] && return 1
    
    echo "Suche nach: $query"
    jira issue list --jql="text ~ \"$query\"" --plain
}

# Epic management
j.epic() {
    local project_key=$(j.project:select)
    [ -z "$project_key" ] && return 1
    
    local action=$(ui.select_option "Epic Aktion: " "Alle Epics\nEpic Details\nEpic Issues")
    
    case "$action" in
        "Alle Epics")
            jira epic list --project="$project_key"
            ;;
        "Epic Details"|"Epic Issues")
            local epics=$(jira epic list --project="$project_key" --plain --columns="key,summary" --no-headers)
            local selected=$(echo "$epics" | fzf --prompt="Wähle Epic: ")
            
            if [ -n "$selected" ]; then
                local epic_key=$(echo "$selected" | awk '{print $1}')
                if [[ "$action" == "Epic Details" ]]; then
                    jira epic view "$epic_key"
                else
                    jira epic list --epic="$epic_key"
                fi
            fi
            ;;
    esac
}

# Server info
j.info() {
    jira serverinfo
}

# Show current user
j.whoami() {
    jira me
}