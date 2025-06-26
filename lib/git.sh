#!/bin/bash
# Git Hilfsfunktionen für allgemeine Git-Operationen

# Prüft ob das aktuelle Verzeichnis ein Git-Repository ist
# Rückgabe: 0 wenn Git-Repo, 1 wenn nicht
git.check_repo() {
    git rev-parse --git-dir > /dev/null 2>&1
}

# Ermittelt den Standard-Branch (main oder master) des Repositories  
# Rückgabe: "main", "master" oder leer wenn keiner gefunden
git.get_default_branch() {
    local main_exists=$(git branch -a | grep -c "main$")
    local master_exists=$(git branch -a | grep -c "master$")
    
    if [ $main_exists -gt 0 ]; then
        echo "main"
    elif [ $master_exists -gt 0 ]; then
        echo "master"
    else
        echo ""
    fi
}

# Listet alle verfügbaren Branches (lokal und remote) auf
# Rückgabe: Sortierte Liste aller Branches ohne Duplikate
git.get_all_branches() {
    git branch -a | sed 's/remotes\/origin\///g' | sed 's/^\*\?\s*//g' | grep -v '^HEAD' | sort -u
}

# Prüft ob es uncommitted Änderungen im Repository gibt
# Gibt Warnung aus wenn Änderungen vorhanden sind
# Rückgabe: 0 wenn keine Änderungen, 1 wenn Änderungen vorhanden
git.check_uncommitted_changes() {
    if ! git diff-index --quiet HEAD --; then
        echo "Warnung: Es gibt uncommitted Änderungen im Repository!"
        git status --porcelain
        return 1
    fi
    return 0
}

# Prüft ob ein Branch remote Updates hat und gibt entsprechende Meldung aus
# Parameter: $1 = Branch-Name
# Rückgabe: 0 wenn kein Update, 1 wenn Updates verfügbar
git.check_remote_updates() {
    local base_branch="$1"
    
    # Branch existiert nicht lokal, Check überspringen
    git show-ref --verify --quiet refs/heads/"$base_branch" || return 0
    
    # Remote Branch holen
    git fetch origin "$base_branch" 2>/dev/null || return 0
    
    local local_commit=$(git rev-parse "$base_branch" 2>/dev/null)
    local remote_commit=$(git rev-parse "origin/$base_branch" 2>/dev/null)
    
    # Kein Remote oder Commits sind gleich
    if [ -z "$remote_commit" ] || [ "$local_commit" = "$remote_commit" ]; then
        return 0
    fi
    
    # Remote hat Updates
    echo "Remote Branch '$base_branch' hat Updates!"
    return 1
}

# Aktualisiert einen Branch mit den neuesten Remote-Änderungen
# Parameter: $1 = Branch-Name
# Führt checkout und pull für den angegebenen Branch aus
git.update_branch() {
    local base_branch="$1"
    git checkout "$base_branch" && git pull origin "$base_branch"
}