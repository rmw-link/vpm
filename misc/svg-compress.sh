#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd $DIR/../web/file
npx -y svgo --config $DIR/svgo.config.cjs -r -f . -o .
