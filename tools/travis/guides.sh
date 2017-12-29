#!/bin/sh

# Generate Asciidoctor artifacts

docker run --rm -it -v $(pwd):/documents -v $(pwd)/target:/target difi/asciidoctor
