# Evangelisches Gesangbuch Elektronisch auf Mac

## Anleitung zur Installation des Evangelischen Gesangbuchs Elektronisch auf Mac OSX via Wine oder Wineskin Winery als App-Bundle

Diese Anleitung beschreibt die Schritte, um das Evangelische Gesangbuch Elektronisch auf einem Mac unter Verwendung von [Wine](#installation-mit-wine) zu installieren.
Alernativ als [Installation mit Wineskin Winery (empfohlen)](#installation-mit-wineskin-winery) als App-Bundle.
## Inhaltsverzeichnis

1. [Installation mit Wine](#installation-mit-wine)
    1. [Download der aktuellen Version von MFchi](#1-download-der-aktuellen-version-von-mfchi)
    2. [Installation von Homebrew](#2-installation-von-homebrew)
    3. [Installation von Wine und Winetricks](#3-installation-von-wine-und-winetricks)
    4. [Installation der MFchi-Datei](#4-installation-der-mfchi-datei)
    5. [Installation der erforderlichen Dateien mit Winetricks](#5-installation-der-erforderlichen-dateien-mit-winetricks)
    6. [Registrierung der DLL für die Textverarbeitung](#6-registrierung-der-dll-für-die-textverarbeitung)
    7. [Starten des Programms über das Terminal](#7-starten-des-programms-über-das-terminal)
    8. [Import der Dateien von der CD und Update](#8-import-der-dateien-von-der-cd-und-update)
    9. [Erstellen eines Shortcuts mit Icon im Applications-Ordner](#9-erstellen-eines-shortcuts-mit-icon-im-applications-ordner)

2. [Installation mit Wineskin Winery (empfohlen)](#installation-mit-wineskin-winery)
    1. [Installation von Homebrew](#1-installation-von-homebrew)
    2. [Wineskin Winery herunterladen und installieren](#2-wineskin-winery-herunterladen-und-installieren)
    3. [Wineskin Winery einrichten](#3-wineskin-winery-einrichten)
    4. [Wrapper konfigurieren](#4-wrapper-konfigurieren)
    5. [Zusätzliche Bibliotheken und DLLs installieren](#5-zusätzliche-bibliotheken-und-dlls-installieren)
    6. [Registriere die `tx4ole14.ocx`-Datei](#6-registriere-die-tx4ole14ocx-datei)
    7. [Icon hinzufügen](#7-icon-hinzufügen)
    8. [Wrapper als eigenständige App nutzen](#8-wrapper-als-eigenständige-app-nutzen)

---
# Installation mit Wine

Diese Anleitung beschreibt die Schritte, um das Evangelische Gesangbuch Elektronisch auf einem Mac unter Verwendung von Wine zu installieren.

## 1. Download der aktuellen Version von MFchi

Lade die aktuelle Version von MFchi von der offiziellen Website herunter:
[MFchi Download](https://www.mfchi.org/epages/es122753.sf/de_DE/?ObjectPath=/Shops/es122753/Categories/Support/Download/Updates/Update_auf_aktuelle_Version)

## 2. Installation von Homebrew

Öffne das Terminal und installiere Homebrew mit dem folgenden Befehl:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
## 3. Installation von Wine und Winetricks

Installiere Wine und Winetricks über Homebrew:

```sh
brew install --cask wine-stable
brew install winetricks
```

## 4. Installation der MFchi-Datei

Starte die Installation der MFchi-Datei über Wine. Navigiere im Terminal zu dem Verzeichnis, in dem die heruntergeladene Datei gespeichert ist, und führe den folgenden Befehl aus:

```sh
wine path/to/mfchi-setup.exe
```

## 5. Installation der erforderlichen Dateien mit Winetricks

Die Datei mfc42.exe wird für die interne Textverarbeitung von MFchi Pro benötigt und ist eventuell auch für die Installation erforderlich. Installiere sie mit Winetricks:

```sh
winetricks mfc42
```

## 6. Registrierung der DLL für die Textverarbeitung

Für die interne Textverarbeitung muss die tx4ole14.ocx-Datei registriert werden. Führe den folgenden Befehl aus (passe den Pfad zur Installation entsprechend an):

```sh
wine regsvr32 "C:\MFchi\tx4ole14.ocx"
```

## 7. Starten des Programms über das Terminal

Du kannst das Evangelische Gesangbuch Elektronisch nun über das Terminal starten:

```sh
wine "C:/MFchi/mfbo2a32.exe"
```

## 8. Import der Dateien von der CD und Update

Importiere die notwendigen Dateien von der CD, um das Programm vollständig nutzen zu können und Update alle Textversionen.

## 9. Erstellen eines Shortcuts mit Icon im Applications-Ordner

Um das Programm bequem über den Applications-Ordner starten zu können, führe das folgende Skript aus, um einen Shortcut mit Icon zu erstellen. Dazu die Datei create_eg_wine_app.sh herunterladen und die icns Datei herunterladen. Passe die Felder gegebenfalls an.

### Mache das Skript ausführbar:

```sh
chmod +x create_eg_wine_app.sh.sh
```

Führe das Skript aus:

```sh
./create_eg_wine_app.sh.sh
```

Nun solltest du die Anwendung "Evangelisches Gesangbuch" im Applications-Ordner sehen und starten können.

# Installation mit Wineskin Winery (empfohlen)

Diese Anleitung beschreibt die Schritte, um das Evangelische Gesangbuch Elektronisch auf einem Mac unter Verwendung von Wineskin Winery zu installieren und als eigenständige App zu verpacken.

## 1. Installation von Homebrew

Falls Homebrew noch nicht installiert ist, führe diesen Befehl im Terminal aus:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Wineskin Winery herunterladen und installieren

Installiere Wineskin Winery über Homebrew:

```sh
brew install --cask --no-quarantine gcenx/wine/wineskin
```

## 3. Wineskin Winery einrichten

1. Öffne Wineskin Winery und klicke auf "Update" oder "Download", um sicherzustellen, dass du die neueste Engine und Wrapper-Version hast.
2. Klicke auf "+", um einen neuen Wrapper zu erstellen.
3. Gib deinem Wrapper einen Namen, z.B. "EG", und klicke auf "Create". 

## 4. Wrapper konfigurieren

1. Nachdem der Wrapper erstellt wurde, öffne ihn. Du findest ihn in deinem Benutzerverzeichnis unter `~/Applications/Wineskin`.
2. Klicke auf "Install Software" und wähle "Choose Setup Executable".
3. Navigiere zu der MFchi-Setup-Datei und installiere sie.
4. Den Suchvorgang kannst du abbrechen.
5. Nach der Installation wird gefragt, ob das Programm gestartet werden soll. Das kannst du verneinen.
6. Nachdem die Installation abgeschlossen ist, wirst du gefragt, welche Datei gestartet werden soll. Wähle die Hauptausführbare Datei aus, z.B. `C:/Program Files (x86)/bibel digital/mfbo2a32.exe`.

## 5. Zusätzliche Bibliotheken und DLLs installieren

1. Öffne den Wrapper und klicke auf "Advanced".
2. Gehe zu "Tools" und öffne "Winetricks".
3. Installiere `mfc42` über Winetricks.

## 6. Registriere die `tx4ole14.ocx`-Datei

1. Öffne den Wrapper und klicke auf "Advanced".
2. Gehe zu "Tools" und öffne "Commandline".
3. Registriere die `tx4ole14.ocx`-Datei:
```sh
regsvr32 "C:\Program Files (x86)\bibel digital\tx4ole14.ocx"
```

## 7. Icon hinzufügen

1. Öffne den Wrapper und klicke auf "Advanced".
2. Gehe zu "Configuration" und klicke auf "Browse" neben dem Icon-Feld.
3. Wähle das Icon aus, das du verwenden möchtest.
4. Nutze gerne das Icon aus diesem Git.

## 8. Wrapper als eigenständige App nutzen

1. Schließe alle offenen Fenster von Wineskin.
2. Der Wrapper, der nun eine vollständige Wine-Umgebung sowie die installierte MFchi-Anwendung enthält, kann nun wie jede andere Mac-Anwendung verwendet werden.
3. Starte das Programm durch einen Doppelklick. Bibel Digital sollte nun starten.
4. Über Einbindung die Textdateien importieren und über Online die Updates einspielen.
5. Kopiere den Wrapper einfach auf einen anderen Mac, und es sollte sofort einsatzbereit sein.

