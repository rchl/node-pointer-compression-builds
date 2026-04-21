#!/bin/bash

set -e
cd $(dirname $0)

NODE_TAG=v24.14.1

git clone --depth 1 --branch "$NODE_TAG" https://github.com/nodejs/node.git node-src
cd node-src
git apply ../patches/support_v8_sandboxed_pointers.patch
git apply ../patches/0001-apply-some-build-fixes-from-electron.patch
./configure \
    --ninja \
    --experimental-enable-pointer-compression \
    --experimental-pointer-compression-shared-cage \
    --without-siphash \
    --prefix=/usr/local
make
rm -rf $(pwd)/../release
make install DESTDIR=$(pwd)/../release
