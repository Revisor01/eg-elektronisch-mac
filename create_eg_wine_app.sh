#!/bin/bash

# Name der App
APP_NAME="Evangelisches Gesangbuch"

# Pfad zur Windows-Anwendung
WINDOWS_APP_PATH="C:/Program Files (x86)/mfbo2a32.exe"

# Pfad zum Icon
ICON_PATH="~/Downloads/eg-elektronisch.icns"

# Pfad zum Applications-Ordner
APPLICATIONS_FOLDER="/Applications"

# Verzeichnisse erstellen
mkdir -p "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/MacOS"
mkdir -p "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/Resources"

# Shell-Skript erstellen, das die Windows-Anwendung startet
cat <<EOL > "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/MacOS/start-windows-app.sh"
#!/bin/bash
# Set environment variables for Wine
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export WINEPREFIX=\$HOME/.wine
export WINEARCH=win32
# Start the Windows application with Wine
/opt/homebrew/bin/wine "$WINDOWS_APP_PATH"
EOL

# Shell-Skript ausführbar machen
chmod +x "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/MacOS/start-windows-app.sh"

# Info.plist Datei erstellen
cat <<EOL > "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>start-windows-app.sh</string>
    <key>CFBundleIdentifier</key>
    <string>com.yourdomain.$APP_NAME</string>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleIconFile</key>
    <string>eg-elektronisch.icns</string>
</dict>
</plist>
EOL

# Icon-Datei kopieren
cp "$ICON_PATH" "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/Resources/eg-elektronisch.icns"

echo "Die Anwendung $APP_NAME wurde erfolgreich im Applications-Ordner erstellt."
