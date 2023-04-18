#!/bin/bash

set -e
set -x

source manifest;

sudo mkdir -p /workdir/pkgs
sudo chown -R build:build /workdir/pkgs
PIKAUR_CMD="PKGDEST=/workdir/pkgs pikaur --noconfirm -S -P /workdir/${1}PKGBUILD"
PIKAUR_RUN=(bash -c "${PIKAUR_CMD}")
"${PIKAUR_RUN[@]}"
# remove any epoch (:) in name, replace with -- since not allowed in artifacts
find /workdir/pkgs/*.pkg.tar* -type f -name '*:*' -execdir bash -c 'mv "$1" "${1//:/--}"' bash {} \;