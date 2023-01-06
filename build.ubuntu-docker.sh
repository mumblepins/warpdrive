#!/usr/bin/env bash
set -e
docker build -f Dockerfile.ubuntu . -t warpdrive-builder:latest

ARROW_GIT_REPOSITORY="${ARROW_GIT_REPOSITORY:=/opt/arrow}"
ARROW_GIT_TAG="${ARROW_GIT_TAG:=b050bd0d31db6412256cec3362c0d57c9732e1f2}"
ODBCABSTRACTION_REPO="${ODBCABSTRACTION_REPO:=/opt/flightsql-odbc}"
ODBCABSTRACTION_GIT_TAG="${ODBCABSTRACTION_GIT_TAG:=92b82d7d74362840d695ee03814a26e75cf1e92e}"
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
