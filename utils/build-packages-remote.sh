#! /bin/bash
set -e
docker pull ghcr.io/chimeraos/chimeraos:master
docker run --entrypoint /workdir/pkgs/build-packages.sh -v $(pwd):/workdir:Z ghcr.io/chimeraOS/chimeraos:master
