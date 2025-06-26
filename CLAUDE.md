# CLAUDE.md

Diese Datei bietet Anweisungen für Claude Code (claude.ai/code) bei der Arbeit mit Code in diesem Repository.

## Repository Übersicht

Dies ist eine Sammlung von Shell-Aliases und Hilfsfunktionen für zsh/bash, die Shortcuts für häufige Entwicklungsaufgaben bereitstellen. Das Repository enthält modulare Shell-Script-Dateien, die einzeln oder kollektiv geladen werden können, um die Kommandozeilen-Produktivität zu steigern.

## Architektur

Das Repository folgt einem modularen Ansatz, bei dem jede `.sh`-Datei verwandte Aliases und Funktionen enthält:

- `k8s.sh` - Kubernetes/kubectl Shortcuts und Utilities mit Context/Namespace-Management
- `docker.sh` - Docker Container-Management Aliases und Hilfsfunktionen  
- `docker-compose.sh` - Docker Compose Shortcuts
- `misc.sh` - Allgemeine Aliases (Git, Editoren, Dateioperationen, System-Utilities)
- `just.sh` - Just Command Runner Aliases
- `jira.sh` - Jira CLI Integration mit fzf für Ticket-Management

## Bibliothekssystem (lib/)

Das Repository nutzt ein modulares Bibliothekssystem im `lib/`-Verzeichnis:

### Git Hilfsfunktionen (`lib/git.sh`)
- `git.check_repo()` - Prüft ob aktuelles Verzeichnis ein Git-Repository ist
- `git.get_default_branch()` - Ermittelt Standard-Branch (main/master)
- `git.get_all_branches()` - Listet alle verfügbaren Branches auf
- `git.check_uncommitted_changes()` - Prüft auf uncommitted Änderungen
- `git.check_remote_updates()` - Prüft auf Remote-Updates für Branch
- `git.update_branch()` - Aktualisiert Branch mit Remote-Änderungen

### UI Hilfsfunktionen (`lib/ui.sh`)
- `ui.select_option()` - fzf-Auswahl mit gegebenen Optionen
- `ui.confirm()` - Ja/Nein-Bestätigung
- `ui.select_with_exit()` - Auswahlmenü mit Exit-Option
- `ui.select_branch_action()` - Branch-Update-Aktionen
- `ui.read_input()` - Benutzereingabe mit Prompt

## Hauptkomponenten

### Kubernetes Utilities (`k8s.sh`)
- Lazy-loaded kubectl completion via `k()` Funktion
- Context-Wechsel mit fzf-Integration: `k.context:change`
- Namespace-Management: `k.ns:change`
- Resource-Shortcuts: `k.g` (get), `k.d` (describe), `k.rm` (delete)

### Docker Helpers (`docker.sh`)
- Container-Ausführungsfunktion `d.e()` mit intelligenter bash/command-Erkennung
- Formatierte Container-Auflistung mit `d.ps`-Varianten für verschiedene Service-Typen
- Bulk-Operationen wie `d.rm.all` und `d.rmi.untagged`

### Git Branch Management (`misc.sh`)
- `g.branch:new()` - Interaktive Branch-Erstellung mit fzf
  - Automatische main/master-Erkennung
  - Base-Branch-Auswahl (Standard-Branch oder anderer Branch)  
  - Uncommitted-Changes-Prüfung mit Bestätigung
  - Remote-Update-Check mit Update-Option
  - Konfigurierbare Branch-Prefixes (feature/TOFU-, bug/TOFU-, hotfix/TOFU-, Custom)
  - Suffix-Eingabe für vollständigen Branch-Namen

### Jira Integration (`jira.sh`)
- `j.setup()` - Setup-Anleitung für Jira CLI Konfiguration
- `j.ticket:search()` - Interactive Ticket-Suche mit fzf-Integration
- `j.ticket:show()` - Ticket-Details anzeigen
- `j.ticket:open()` - Ticket im Browser öffnen
- `j.ticket:new()` - Neues Ticket erstellen
- `j.my()` - Persönliche Tickets (zugewiesen, erstellt, beobachtet)
- `j.search()` - Projekt-übergreifende Suche
- `j.board()` - Board-Management
- `j.sprint()` - Sprint-Management mit Auswahl
- `j.epic()` - Epic-Management und -Details
- `j.info()` - Server-Informationen
- `j.whoami()` - Aktueller Benutzer

### System-Integration
- Nutzt externe Tools: `fzf` (fuzzy finder), `bat` (syntax highlighting), `eza` (ls replacement), `jira-cli`
- Projekt-Navigation mit `p` Alias using fzf zum Durchsuchen von ~/Documents/Projekte/
- Passwort-Generierung mit verschiedenen Sicherheitsstufen

## Verwendungsmuster

Dateien sind zum Laden in der Shell-Konfiguration konzipiert:
```bash
# Alle Dateien laden
for file in ~/.aliases/*.sh; do source $file; done

# Einzelne Dateien laden  
source ~/.aliases/docker.sh
source ~/.aliases/jira.sh

# Bibliotheken werden automatisch von misc.sh und jira.sh geladen
source ~/.aliases/lib/git.sh
source ~/.aliases/lib/ui.sh
```

## Entwicklungshinweise

- Alle Dateien sind ausführbare Shell-Scripts
- Funktionen verwenden konsistente Namenskonventionen (tool.action:variant)
- Komplexe Utilities verwenden Hilfsfunktionen anstatt komplexe Aliases
- Bibliotheksfunktionen sind thematisch in `lib/`-Verzeichnis organisiert
- Repository verwendet Git mit master als Hauptbranch
- Deutsche Dokumentation für alle Bibliotheksfunktionen