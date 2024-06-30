# Evangelisches Gesangbuch Elektronisch auf Mac

## Anleitung zur Installation des Evangelischen Gesangbuchs Elektronisch auf Mac OSX

Diese Anleitung beschreibt die Schritte, um das Evangelische Gesangbuch Elektronisch auf einem Mac unter Verwendung von Wine zu installieren.

### 1. Download der aktuellen Version von MFchi

Lade die aktuelle Version von MFchi von der offiziellen Website herunter:
[MFchi Download](https://www.mfchi.org/epages/es122753.sf/de_DE/?ObjectPath=/Shops/es122753/Categories/Support/Download/Updates/Update_auf_aktuelle_Version)

### 2. Installation von Homebrew

Öffne das Terminal und installiere Homebrew mit dem folgenden Befehl:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
### 3. Installation von Wine und Winetricks

Installiere Wine und Winetricks über Homebrew:

```sh
brew install --cask wine-stable
brew install winetricks
```

### 4. Installation der MFchi-Datei

Starte die Installation der MFchi-Datei über Wine. Navigiere im Terminal zu dem Verzeichnis, in dem die heruntergeladene Datei gespeichert ist, und führe den folgenden Befehl aus:

```sh
wine path/to/mfchi-setup.exe
```

### 5. Installation der erforderlichen Dateien mit Winetricks

Die Datei mfc42.exe wird für die interne Textverarbeitung von MFchi Pro benötigt und ist eventuell auch für die Installation erforderlich. Installiere sie mit Winetricks:

```sh
winetricks mfc42
```


### 6. Registrierung der DLL für die Textverarbeitung

Für die interne Textverarbeitung muss die tx4ole14.ocx-Datei registriert werden. Führe den folgenden Befehl aus (passe den Pfad zur Installation entsprechend an):

```sh
wine regsvr32 "C:\MFchi\tx4ole14.ocx"
```

### 7. Starten des Programms über das Terminal

Du kannst das Evangelische Gesangbuch Elektronisch nun über das Terminal starten:

```sh
wine "C:/MFchi/mfbo2a32.exe"
```

### 8. Import der Dateien von der CD und Update

Importiere die notwendigen Dateien von der CD, um das Programm vollständig nutzen zu können und Update alle Textversionen.

### 9. Erstellen eines Shortcuts mit Icon im Applications-Ordner

Um das Programm bequem über den Applications-Ordner starten zu können, führe das folgende Skript aus, um einen Shortcut mit Icon zu erstellen. Dazu die Datei create_eg_wine_app.sh herunterladen und die icns Datei herunterladen. Passe die Felder gegebenfalls an.

#### Mache das Skript ausführbar:

```sh
chmod +x create_eg_wine_app.sh.sh
```

Führe das Skript aus:

```sh
./create_eg_wine_app.sh.sh
```

Nun solltest du die Anwendung "Evangelisches Gesangbuch" im Applications-Ordner sehen und starten können.
