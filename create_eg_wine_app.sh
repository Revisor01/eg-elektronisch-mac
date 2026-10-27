#!/bin/bash

APP_NAME="Evangelisches Gesangbuch"

WINDOWS_APP_PATH="C:/Program Files (x86)/mfbo2a32.exe"

# In Anführungszeichen löst die Shell "~" nicht auf.
ICON_PATH="${ICON_PATH:-$HOME/Downloads/eg-elektronisch.icns}"

if [ ! -f "$ICON_PATH" ]; then
    echo "Icon nicht gefunden: $ICON_PATH (Pfad per ICON_PATH=... angeben)" >&2
    exit 1
fi

APPLICATIONS_FOLDER="/Applications"

mkdir -p "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/MacOS"
mkdir -p "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/Resources"

cat <<EOL > "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/MacOS/start-windows-app.sh"
#!/bin/bash
# Set environment variables for Wine
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export WINEPREFIX=\$HOME/.wine
export WINEARCH=win32
# Start the Windows application with Wine
/opt/homebrew/bin/wine "$WINDOWS_APP_PATH"
EOL

chmod +x "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/MacOS/start-windows-app.sh"

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

cp "$ICON_PATH" "$APPLICATIONS_FOLDER/$APP_NAME.app/Contents/Resources/eg-elektronisch.icns"

echo "Die Anwendung $APP_NAME wurde erfolgreich im Applications-Ordner erstellt."
