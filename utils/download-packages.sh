#!/bin/bash

set -e
set -x

source /manifest;

mkdir /nothing
PIKAUR_CMD="pacman --dbpath /nothing --cachedir /output --noconfirm -Syyw ${KERNEL_PACKAGE} ${KERNEL_PACKAGE}-headers ${PACKAGES}"
PIKAUR_RUN=(bash -c "${PIKAUR_CMD}")
"${PIKAUR_RUN[@]}"
# remove any epoch (:) in name, replace with -- since not allowed in artifacts
find /output/*.pkg.tar* -type f -name '*:*' -execdir bash -c 'mv "$1" "${1//:/--}"' bash {} \;