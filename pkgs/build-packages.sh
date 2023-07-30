#!/bin/bash

set -e
set -x

source manifest;

sudo chown build:build /workdir/pkgs

mkdir -p /tmp/pkgs
cp -rv /workdir/pkgs/**/ /tmp/pkgs/.
for package in /tmp/pkgs/*; do
	echo "Building ${package}"
    PIKAUR_CMD="PKGDEST=/workdir/pkgs pikaur --noconfirm -S -P ${package}/PKGBUILD --mflags=--skippgpcheck"
    PIKAUR_RUN=(bash -c "${PIKAUR_CMD}")
    "${PIKAUR_RUN[@]}"
done