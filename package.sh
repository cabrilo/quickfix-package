#!/bin/bash

QF_VERSION=$1

rm -rf quickfix

git clone --depth 1 https://github.com/quickfix/quickfix.git
rm -rf quickfix/.git

pushd quickfix/doc
./document.sh
popd

pushd quickfix
../git2cl > ChangeLog
./bootstrap
popd

rm -f quickfix-$QF_VERSION.tar.gz

tar czvf quickfix-$QF_VERSION.tar.gz quickfix

pushd quickfix
./booststrap
# TODO: Handle params here
# TODO: Check if we even need make here - what's the point, we are building python3 module from sources. 
# TODO: Add make check postgresql dependencies (create db, etc.) if make is even needed
./configure --with-python3 --with-postgresql --with-openssl
popd
