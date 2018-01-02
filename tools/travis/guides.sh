#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..

# Generate Asciidoctor artifacts

docker run --rm -i -v $FOLDER:/documents -v $FOLDER/target:/target difi/asciidoctor
