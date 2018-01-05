#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..
. $FOLDER/tools/script/common.sh

info "Generate documentation artifacts"
docker run --rm -i -v $FOLDER:/documents -v $FOLDER/target:/target difi/asciidoctor
