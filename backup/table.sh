#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

function dump {
mkdir -p table
FILE=table/$1.sql
echo $FILE
pg_dump $pg_url --no-owner --no-acl -s -n $1 -f $FILE
sed  -i '/^-- .* version .*/d' $FILE
}

. dump.sh
