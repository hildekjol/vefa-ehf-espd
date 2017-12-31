#!/bin/sh

# EHF ESPD Request

docker run --rm -it \
-v $(pwd):/src \
-v $(pwd)/target/structure/espd-request:/target \
difi/vefa-structure:0.4.1 \
-p /src/structure/espd-request -t /target

# EHF ESPD Response

docker run --rm -it \
-v $(pwd):/src \
-v $(pwd)/target/structure/espd-response:/target \
difi/vefa-structure:0.4.1 \
-p /src/structure/espd-response -t /target