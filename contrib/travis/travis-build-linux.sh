#!/bin/bash
BUILD_REPO_URL=https://github.com/akhavr/electrum-PAC.git

cd build

if [[ -z $TRAVIS_TAG ]]; then
  exit 0
else
  git clone --branch $TRAVIS_TAG $BUILD_REPO_URL electrum-PAC
fi

docker run --rm -v $(pwd):/opt -w /opt/electrum-PAC -t akhavr/electrum-PAC-release:Linux /opt/build_linux.sh
docker run --rm -v $(pwd):/opt -v $(pwd)/electrum-PAC/:/root/.wine/drive_c/electrum -w /opt/electrum-PAC -t akhavr/electrum-PAC-release:Wine /opt/build_wine.sh
