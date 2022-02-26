#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex
./vsh/dialog.vsh
cd src
echo 'export default 0' > config/is_dev.js
npx coffee -bc ./vite.config.coffee ./config/*.coffee
npx vite build
