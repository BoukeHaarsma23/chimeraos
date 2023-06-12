#!/bin/bash

set -e
set -x

source /manifest;

PIKAUR_CMD="pacman --noconfirm -Sw ${KERNEL_PACKAGE} ${KERNEL_PACKAGE}-headers ${PACKAGES}"
PIKAUR_RUN=(bash -c "${PIKAUR_CMD}")
"${PIKAUR_RUN[@]}"