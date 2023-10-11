#! /bin/bash
# This script will build the full image on your local machine.
# It will do this via a base archlinux docker image and compiling everything on top.
set -e
# Pull base image
docker pull archlinux:base-devel
# Create local docker container with chimera-full-local tag
# This will build all PKGBUILDS in the pkgs folder and put them in the docker container.
# Remove the --no-cache if you don't need a clean build everytime.
docker build --no-cache -t chimera-full-local:latest .
# Build AUR packages from manifest locally and put them in aur-pkgs folder
source manifest
for package in ${AUR_PACKAGES}; do
    docker run -it --rm --entrypoint /workdir/aur-pkgs/build-aur-package.sh -v $(pwd):/workdir:Z chimera-full-local:latest "$package"
done
# Build all custom pkgs
for package in pkgs/*/; do
    docker run -it --rm --entrypoint /workdir/pkgs/build-package.sh -v $(pwd):/workdir:Z chimera-full-local:latest "$package"
done
