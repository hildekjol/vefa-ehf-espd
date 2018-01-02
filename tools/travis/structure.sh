#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..

# EHF ESPD Request

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/structure/espd-request:/target \
difi/vefa-structure:0.4.1 \
-p /src/structure/espd-request -t /target

# EHF ESPD Response

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/structure/espd-response:/target \
difi/vefa-structure:0.4.1 \
-p /src/structure/espd-response -t /target
