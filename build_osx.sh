#!/usr/bin/env bash

#
# Copyright (C) 2020-2022 Dremio Corporation
#
# See “license.txt” for license information.

# This script is to facilitate building the Driver on Mac OSX

set -e

vcpkg/vcpkg install --triplet x64-osx --x-install-root=vcpkg/installed

source build.common.sh
mkdir -p build
cd build

cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DVCPKG_TARGET_TRIPLET=x64-osx \
  -DCMAKE_TOOLCHAIN_FILE=../vcpkg/scripts/buildsystems/vcpkg.cmake \
  -DARROW_GIT_REPOSITORY=$ARROW_GIT_REPOSITORY \
  -DARROW_GIT_TAG=$ARROW_GIT_TAG \
  -DODBCABSTRACTION_REPO=$ODBCABSTRACTION_REPO \
  -DODBCABSTRACTION_GIT_TAG=$ODBCABSTRACTION_GIT_TAG \
  -GNinja \
  -DVCPKG_MANIFEST_MODE=OFF^ \
  ..

cmake --build . --config Release -j 12 || cmake --build . --config Release -j 12 || cmake --build . --config Release -j 12

cd ..
