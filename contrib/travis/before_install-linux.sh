#!/bin/bash

if [[ -z $TRAVIS_TAG ]]; then
  exit 0
fi

cd build

docker build -f Dockerfile-linux -t akhavr/electrum-PAC-release:Linux .
./python-x11_hash-wine.sh
./python-trezor-wine.sh
docker build -f Dockerfile-wine -t akhavr/electrum-PAC-release:Wine .
