#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/structure:/target \
difi/vefa-structure:0.5
