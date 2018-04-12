#!/bin/bash

# Please update these links carefully, some versions won't work under Wine
MINGW_SETUP_URL=https://ayera.dl.sourceforge.net/project/mingw/Installer/mingw-get-setup.exe
X11_HASH_URL=https://github.com/akhavr/x11_hash/archive/1.4.tar.gz

## These settings probably don't need change
export WINEPREFIX=/opt/wine64
#export WINEARCH='win32'

PYHOME=c:/python27
PYTHON="wine $PYHOME/python.exe -OO -B"
MINGW="wine c:/MinGW/bin/mingw-get.exe"

# Let's begin!
cd `dirname $0`
set -e

wine 'wineboot'

cd tmp

# downoad mingw-get-setup.exe
wget -q -O mingw-get-setup.exe "$MINGW_SETUP_URL"
wine mingw-get-setup.exe

echo "add c:\MinGW\bin to PATH using regedit in HKEY_CURRENT_USER/Environment"
regedit

$MINGW install gcc
$MINGW install mingw-utils
$MINGW install mingw32-libz

# Install x11 hash
wget -O x11_hash.tar.gz "$X11_HASH_URL"
tar -xvf x11_hash.tar.gz

cd x11_hash-1.4
$PYTHON setup.py build --compile=mingw32 install