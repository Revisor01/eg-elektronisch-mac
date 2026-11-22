#!/bin/bash
# Prüft eine Kopie des Skripts mit Zielordner im Temp-Verzeichnis. Aufruf: bash tests/create_app_test.sh

SOURCE="$(cd "$(dirname "$0")/.." && pwd)/create_eg_wine_app.sh"
failures=0

check() {
    if [ "$2" = "0" ]; then echo "ok   $1"; else echo "FAIL $1"; failures=$((failures + 1)); fi
}

run() {
    T=$(mktemp -d)
    mkdir -p "$T/home/Downloads" "$T/apps"
    SCRIPT="$T/create_eg_wine_app.sh"
    sed "s#^APPLICATIONS_FOLDER=.*#APPLICATIONS_FOLDER=\"$T/apps\"#" "$SOURCE" > "$SCRIPT"
    if ! grep -q "^APPLICATIONS_FOLDER=\"$T/apps\"$" "$SCRIPT"; then
        echo "FAIL Zielordner liess sich nicht umlenken, Abbruch"; exit 1
    fi
}

bundle() { echo "$T/apps/Evangelisches Gesangbuch.app/Contents"; }

# Icon im Downloadordner: der Standardpfad wird aufgelöst und kopiert.
run
echo icon > "$T/home/Downloads/eg-elektronisch.icns"
HOME="$T/home" bash "$SCRIPT" >/dev/null 2>&1
check "Skript endet mit 0, wenn das Icon im Downloadordner liegt" $?
[ -f "$(bundle)/Resources/eg-elektronisch.icns" ]; check "Icon liegt im App-Bundle" $?
[ -x "$(bundle)/MacOS/start-windows-app.sh" ]; check "Startskript ist ausführbar" $?
grep -q "<string>start-windows-app.sh</string>" "$(bundle)/Info.plist"; check "Info.plist nennt das Startskript" $?

# Eigener Pfad über ICON_PATH.
run
echo icon > "$T/eigenes.icns"
HOME="$T/home" ICON_PATH="$T/eigenes.icns" bash "$SCRIPT" >/dev/null 2>&1
check "ICON_PATH wird verwendet" $?
[ -f "$(bundle)/Resources/eg-elektronisch.icns" ]; check "Icon aus ICON_PATH liegt im App-Bundle" $?

# Ohne Icon: Abbruch mit Meldung, kein halbes Bundle.
run
HOME="$T/home" bash "$SCRIPT" >/dev/null 2>"$T/err"
[ $? -eq 1 ]; check "ohne Icon endet das Skript mit 1" $?
grep -q "Icon nicht gefunden" "$T/err"; check "ohne Icon kommt eine Meldung" $?
[ ! -e "$T/apps/Evangelisches Gesangbuch.app" ]; check "ohne Icon entsteht kein App-Bundle" $?

# Vorgabe passt zur Installation laut README, eigener Pfad über WINDOWS_APP_PATH.
run
echo icon > "$T/home/Downloads/eg-elektronisch.icns"
HOME="$T/home" bash "$SCRIPT" >/dev/null 2>&1
grep -qF 'wine "C:/MFchi/mfbo2a32.exe"' "$(bundle)/MacOS/start-windows-app.sh"; check "Vorgabe startet C:/MFchi/mfbo2a32.exe" $?
run
echo icon > "$T/home/Downloads/eg-elektronisch.icns"
HOME="$T/home" WINDOWS_APP_PATH="C:/Program Files (x86)/bibel digital/mfbo2a32.exe" bash "$SCRIPT" >/dev/null 2>&1
grep -qF 'wine "C:/Program Files (x86)/bibel digital/mfbo2a32.exe"' "$(bundle)/MacOS/start-windows-app.sh"; check "WINDOWS_APP_PATH wird verwendet" $?

if [ "$failures" -eq 0 ]; then echo "Alle Prüfungen bestanden"; else echo "$failures Prüfung(en) fehlgeschlagen"; fi
exit $((failures > 0))
