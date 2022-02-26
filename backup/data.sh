#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

function dump {
  mkdir -p data
  FILE=data/$1.sql
  echo $FILE
  pg_dump $pg_url --data-only -n $1 --format=p -f $FILE
}

. dump.sh
