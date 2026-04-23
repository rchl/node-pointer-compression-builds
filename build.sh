#!/bin/bash

set -e
cd $(dirname $0)

NODE_TAG=v24.15.0
NODE_DIR="node-src-$NODE_TAG"

if [ ! -d "$NODE_DIR" ]; then
  git clone --depth 1 --branch "$NODE_TAG" https://github.com/nodejs/node.git "$NODE_DIR"
  cd "$NODE_DIR" && ./../script/git-import-patches ../patches && cd -
fi
cd "$NODE_DIR"
./configure \
    --ninja \
    --experimental-enable-pointer-compression \
    --experimental-pointer-compression-shared-cage \
    --openssl-use-def-ca-store \
    --without-siphash \
    --prefix=/usr/local
make
rm -rf $(pwd)/../release || true
make install DESTDIR=$(pwd)/release
