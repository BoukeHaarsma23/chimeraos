#!/bin/bash

set -e
set -x

source manifest;

sudo mkdir -p /workdir/custom-pkgs
sudo chown -R build:build /workdir/custom-pkgs
PIKAUR_CMD="PKGDEST=/workdir/custom-pkgs pikaur --noconfirm -S -P /workdir/${1}PKGBUILD"
PIKAUR_RUN=(bash -c "${PIKAUR_CMD}")
"${PIKAUR_RUN[@]}"
# remove any epoch (:) in name, replace with -- since not allowed in artifacts
find /workdir/custom-pkgs/*.pkg.tar* -type f -name '*:*' -execdir bash -c 'mv "$1" "${1//:/--}"' bash {} \;