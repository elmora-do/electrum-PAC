#!/bin/bash
BUILD_REPO_URL=https://github.com/devfsc/electrum-PAC.git

export PATH="/usr/local/opt/python@2/bin:$PATH"
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"

cd build

git clone https://github.com/devfsc/electrum-PAC

cd electrum-PAC

source ./contrib/travis/electrum_PAC_version_env.sh;
echo wine build version is $ELECTRUM_PAC_VERSION

sudo pip2 install \
    dnspython==1.12.0 \
    pyaes==1.6.1 \
    ecdsa==0.13 \
    requests==2.5.1 \
    six==1.11.0 \
    qrcode==5.1 \
    pbkdf2==1.3 \
    jsonrpclib==0.1.7 \
    PySocks==1.6.7 \
    x11_hash>=1.4 \
    protobuf==2.6.1 \
    mnemonic==0.18 \
    btchip-python==0.1.23 \
    keepkey==0.7.3 \
    git+https://github.com/trezor/python-trezor@0.7.x

pyrcc4 icons.qrc -o gui/qt/icons_rc.py

cp contrib/osx.spec .
cp contrib/pyi_runtimehook.py .
cp contrib/pyi_tctl_runtimehook.py .
mkdir -p packages/requests
cp /usr/local/lib/python2.7/site-packages/requests/cacert.pem packages/requests/

pyinstaller \
    -y \
    --name electrum-PAC-$ELECTRUM_PAC_VERSION.bin \
    osx.spec

sudo hdiutil create -fs HFS+ -volname "Electrum-PAC" \
    -srcfolder dist/Electrum-PAC.app \
    dist/electrum-PAC-$ELECTRUM_PAC_VERSION-macosx.dmg
