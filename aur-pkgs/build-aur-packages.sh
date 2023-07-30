#!/bin/bash

set -e
set -x

source manifest;

sudo chown build:build /workdir/aur-pkgs

for package in ${AUR_PACKAGES}; do
	echo "Building ${package}"
    sudo mkdir -p /temp/${package}
    sudo chown build:build /temp/${package}
    git clone --depth=1 https://aur.archlinux.org/${package}.git /temp/${package}

    PIKAUR_CMD="PKGDEST=/workdir/aur-pkgs pikaur --noconfirm -S -P /temp/${package}/PKGBUILD --mflags=--skippgpcheck"
    PIKAUR_RUN=(bash -c "${PIKAUR_CMD}")
    "${PIKAUR_RUN[@]}"
done