#!/usr/bin/env bash
set -e
docker build -f Dockerfile.ubuntu . -t warpdrive-builder:latest

source build.common.sh

PDIR="$(cd .. && pwd)"

docker run -it \
  -v "$PDIR/warpdrive":/opt/warpdrive \
  -v "$PDIR/flightsql-odbc":/opt/flightsql-odbc \
  -v "$PDIR/arrow":/opt/arrow \
  --rm --name warpdrive \
  --add-host=host.docker.internal:host-gateway \
  -e ARROW_GIT_REPOSITORY \
  -e ARROW_GIT_TAG \
  -e ODBCABSTRACTION_REPO \
  -e ODBCABSTRACTION_GIT_TAG \
  warpdrive-builder:latest
