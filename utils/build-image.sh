#! /bin/bash
# This script will build the full image on your local machine.
set -e

# Build chimera image using the AUR packages found in aur-pkgs.
# If the -e NO_COMPRESS=1 gets removed, the docker container will tar the ouput image
# needs to be run as root for mount privileges
sudo docker run -it --rm -u root --privileged=true --entrypoint /workdir/build-image.sh -e NO_COMPRESS=1 -v $(pwd):/workdir:Z -v $(pwd)/output:/output:z chimera-full-local:latest $(echo local-$(git rev-parse HEAD | cut -c1-7))
