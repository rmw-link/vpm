#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./vsh/dialog.vsh
cd src
echo 'export default 1' > config/is_dev.js
npx coffee -bc ./vite.config.coffee ./config/*.coffee
npx vite
#npx concurrently --kill-others "vite preview --host 0.0.0.0" "yarn dev"
