#!/bin/bash
# UI Hilfsfunktionen mit fzf für interaktive Auswahlen

# Zeigt eine fzf-Auswahl mit gegebenen Optionen
# Parameter: $1 = Prompt-Text, $2+ = Optionen (durch \n getrennt)
# Rückgabe: Ausgewählte Option oder leer bei Abbruch  
ui.select_option() {
    local prompt="$1"
    shift
    local options="$*"
    
    echo -e "$options" | fzf --prompt="$prompt"
}

# Zeigt eine Ja/Nein-Bestätigung
# Parameter: $1 = Bestätigungstext
# Rückgabe: 0 wenn "Ja", 1 wenn "Nein" oder Abbruch
ui.confirm() {
    local message="$1"
    local choice=$(echo -e "Ja\nNein" | fzf --prompt="$message")
    [ "$choice" = "Ja" ]
}

# Zeigt Auswahlmenü mit automatischer "Exit"-Option
# Parameter: $1 = Prompt-Text, $2+ = Optionen
# Rückgabe: Ausgewählte Option oder 1 bei Exit/Abbruch
ui.select_with_exit() {
    local prompt="$1"
    shift
    local options="$*"
    
    local choice=$(echo -e "${options}\nExit" | fzf --prompt="$prompt")
    
    if [ -z "$choice" ] || [ "$choice" = "Exit" ]; then
        return 1
    fi
    
    echo "$choice"
}

# Spezielle Auswahl für Branch-Update-Aktionen
# Parameter: $1 = Branch-Name (wird aktuell nicht verwendet)
# Rückgabe: 0 = Update, 1 = Ohne Update, 2 = Abbrechen
ui.select_branch_action() {
    local branch="$1"
    local action=$(echo -e "Branch lokal aktualisieren\nOhne Update fortfahren\nAbbrechen" | fzf --prompt="Branch Update verfügbar: ")
    
    case "$action" in
        "Branch lokal aktualisieren")
            return 0
            ;;
        "Ohne Update fortfahren")
            return 1
            ;;
        *)
            return 2
            ;;
    esac
}

# Fordert Benutzereingabe mit Prompt an
# Parameter: $1 = Eingabeaufforderung
# Rückgabe: Eingegebener Text oder 1 bei leerer Eingabe
ui.read_input() {
    local prompt="$1"
    local input
    
    # Read from terminal directly to avoid subshell issues
    echo -n "$prompt" >&2
    read input </dev/tty
    
    if [ -z "$input" ]; then
        return 1
    fi
    
    echo "$input"
}