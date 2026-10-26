<p align="center">
  <img src="eg-elektronisch.png" alt="EG elektronisch" width="128" height="128">
</p>

<h1 align="center">EG elektronisch on the Mac</h1>

<p align="center">
  The electronic Protestant hymnal of Germany (MFchi) on macOS —<br>
  with Wine or as a standalone app via Wineskin.
</p>

<p align="center">
  <a href="README.md">Deutsch</a> · <b>English</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-macOS%2014%2B-blue" alt="Platform">
  <img src="https://img.shields.io/github/license/Revisor01/eg-elektronisch-mac" alt="License">
</p>

## What it is about

The "Evangelisches Gesangbuch elektronisch", the electronic edition of the
German Protestant hymnal, only exists for Windows. Anyone in a parish office
or in church music who uses a Mac has so far needed a Windows machine or a
virtual machine for it.

This repository describes how to run the program with Wine directly on the
Mac, and brings a script and an icon so that it sits in the Applications folder
like any other app. The program itself and its texts are in German.

## Features

- **Two ways** — Wine via Homebrew, or a Wineskin wrapper as a standalone app
- **App in the Applications folder** — `create_eg_wine_app.sh` creates a
  launcher "Evangelisches Gesangbuch" with an icon
- **Word processing** — the required registration of `tx4ole14.ocx` and
  `mfc42` is described
- **Icon** — `eg-elektronisch.icns` and `eg-elektronisch.png`

## Compatibility

| Counterpart | Required | Last tested against |
|-------------|----------|---------------------|
| macOS | with Homebrew and Wine | macOS 14.5 Sonoma, Apple Silicon |
| EG elektronisch | the MFchi installer and the text CD | — |

## Installation

You need a valid licence for the program: the MFchi installer and the CD with
the texts.

### Installing with Wine

#### 1. Download the current MFchi version

Download the current version of MFchi from the official website:
[MFchi download](https://www.mfchi.org/epages/es122753.sf/de_DE/?ObjectPath=/Shops/es122753/Categories/Support/Download/Updates/Update_auf_aktuelle_Version)

#### 2. Install Homebrew

Open Terminal and install Homebrew with this command:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 3. Install Wine and Winetricks

Install Wine and Winetricks via Homebrew:

```sh
brew install --cask wine-stable
brew install winetricks
```

#### 4. Install the MFchi file

Run the MFchi installer through Wine. In Terminal, go to the folder containing
the downloaded file and run:

```sh
wine path/to/mfchi-setup.exe
```

#### 5. Install the required files with Winetricks

mfc42 is needed for the built-in word processing of MFchi Pro and may also be
needed for the installation. Install it with Winetricks:

```sh
winetricks mfc42
```

#### 6. Register the DLL for word processing

For the built-in word processing, `tx4ole14.ocx` has to be registered. Run
this command (adjust the path to your installation):

```sh
wine regsvr32 "C:\MFchi\tx4ole14.ocx"
```

#### 7. Start the program from Terminal

You can now start the program from Terminal:

```sh
wine "C:/MFchi/mfbo2a32.exe"
```

#### 8. Import the files from the CD and update

Import the required files from the CD to use the program fully, and update all
text versions.

#### 9. Create a launcher with an icon in the Applications folder

To start the program conveniently from the Applications folder, run the
following script, which creates a launcher with an icon. Download
[create_eg_wine_app.sh](create_eg_wine_app.sh) and
[eg-elektronisch.icns](eg-elektronisch.icns) for this.

Check in the script first:

- `WINDOWS_APP_PATH` must point to the installed `mfbo2a32.exe`. With the
  installation above that is `C:/MFchi/mfbo2a32.exe`; the script's default is
  `C:/Program Files (x86)/mfbo2a32.exe`.
- The icon is expected in your Downloads folder as `eg-elektronisch.icns`. If
  it is somewhere else, pass the path when calling:
  `ICON_PATH=/path/to/eg-elektronisch.icns ./create_eg_wine_app.sh`

**Make the script executable:**

```sh
chmod +x create_eg_wine_app.sh
```

Run the script:

```sh
./create_eg_wine_app.sh
```

You should now see the application "Evangelisches Gesangbuch" in the
Applications folder and be able to start it.

### Installing with Wineskin Winery

Packages the program together with a Wine environment into a standalone Mac
app that can be copied to other Macs.

#### 1. Install Homebrew

If Homebrew is not installed yet, run this command in Terminal:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 2. Download and install Wineskin Winery

Install Wineskin Winery via Homebrew:

```sh
brew install --cask --no-quarantine gcenx/wine/wineskin
```

#### 3. Set up Wineskin Winery

1. Open Wineskin Winery and click "Update" or "Download" to make sure you have
   the latest engine and wrapper version.
2. Click "+" to create a new wrapper.
3. Give the wrapper a name, e.g. "EG", and click "Create".

#### 4. Configure the wrapper

1. Once the wrapper has been created, open it. You find it in your home folder
   under `Applications/Wineskin`.
2. Click "Install Software" and choose "Choose Setup Executable".
3. Navigate to the MFchi setup file and install it.
4. You can cancel the search.
5. After the installation you are asked whether to start the program. You can
   say no.
6. When the installation is finished, you are asked which file to start.
   Choose the main executable, e.g.
   `C:/Program Files (x86)/bibel digital/mfbo2a32.exe`.

#### 5. Install additional libraries and DLLs

1. Open the wrapper and click "Advanced".
2. Go to "Tools" and open "Winetricks".
3. Install `mfc42` via Winetricks.

#### 6. Register `tx4ole14.ocx`

1. Open the wrapper and click "Advanced".
2. Go to "Tools" and open "Commandline".
3. Register `tx4ole14.ocx`:
```sh
regsvr32 "C:\Program Files (x86)\bibel digital\tx4ole14.ocx"
```

#### 7. Add the icon

1. Download [eg-elektronisch.icns](eg-elektronisch.icns) or
   [eg-elektronisch.png](eg-elektronisch.png) as the icon.
2. Open the wrapper and click "Advanced".
3. Go to "Configuration" and click "Browse" next to the icon field.
4. Choose the icon you want to use.

#### 8. Use the wrapper as a standalone app

1. Close all open Wineskin windows.
2. The wrapper, which now contains a complete Wine environment and the
   installed MFchi application, can be used like any other Mac application.
3. Start the program with a double click. "Bibel Digital" should now start.
4. Import the text files via "Einbindung" and install the updates via
   "Online".
5. Simply copy the wrapper to another Mac, and it should be ready to use.

## Structure

```
eg-elektronisch-mac
├── create_eg_wine_app.sh   — creates the launcher in /Applications
├── eg-elektronisch.icns    — icon for the launcher
├── eg-elektronisch.png     — icon for Wineskin
└── tests/                  — checks the script without touching /Applications
```

## Contributing

Experiences with other macOS versions or program versions are welcome as an
[issue](https://github.com/Revisor01/eg-elektronisch-mac/issues). Please report
security issues privately as described in [SECURITY.md](SECURITY.md). Pull
requests run through tests and a secret scan; see
[CONTRIBUTING.md](CONTRIBUTING.md).

## License

Instructions, script and icon: [MIT](LICENSE) © 2024–2026 Simon Luthe

## Note

This is an independent guide. The Evangelisches Gesangbuch elektronisch and
MFchi are products of their respective rights holders; the program and the
texts are not part of this repository and require their own licence.

## Contact

Pastor Simon Luthe · [mail@simonluthe.de](mailto:mail@simonluthe.de) ·
[simonluthe.de](https://simonluthe.de)
