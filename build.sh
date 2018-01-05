#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))
. $FOLDER/tools/script/common.sh

if [ -d target ]; then
  info "Delete existing target folder"
  rm -rf target;
fi

sh $FOLDER/tools/travis/rules.sh
sh $FOLDER/tools/travis/guides.sh

info "Fix ownership"
docker run --rm -i -v $FOLDER:/src alpine:3.6 chown -R $(id -g $USER).$(id -g $USER) /src/target
