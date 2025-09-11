#!/usr/bin/env bash

# Installation steps from
# https://appdb.winehq.org/objectManager.php?sClass=version&iId=42297

if [ ! -f Quicken.exe ]; then
  echo "Download and place Quicken.exe in the current directory."
  exit 1
fi

if [ ! -f MicrosoftEdgeWebview2Setup.exe ]; then
  echo "Download the Evergreen Bootstrapper from https://developer.microsoft.com/en-us/microsoft-edge/webview2/?form=MA13LH#download and place the file in the current directory."
  exit 1
fi

WINEARCH=win64 WINEPREFIX=~/.local/share/wineprefixes/Quicken winetricks -q dotnet461
WINEARCH=win64 WINEPREFIX=~/.local/share/wineprefixes/Quicken winetricks settings renderer=gdi
WINEARCH=win64 WINEPREFIX=~/.local/share/wineprefixes/Quicken winetricks -q corefonts
WINEARCH=win64 WINEPREFIX=~/.local/share/wineprefixes/Quicken winetricks -q allfonts
WINEARCH=win64 WINEPREFIX=~/.local/share/wineprefixes/Quicken wine MicrosoftEdgeWebview2Setup.exe
if [ -d DISK1 ]; then
  echo "Folder DISK1 already exists, assuming that Quicken.exe has already been unpacked and updated."
  echo "If this is not the case, delete ~/.local/share/wineprefixes/Quicken and DISK1 and restart."
else
  7z x Quicken.exe
  perl -pi.bak -0777e 's/NOT REMOVE="ALL"InstallPDFDriver/NOT_REMOVE="ALL"InstallPDFDriver/' "DISK1/Quicken.msi"
fi
WINEARCH=win64 WINEPREFIX=~/.local/share/wineprefixes/Quicken wine DISK1/Setup.exe
