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

# Generate basic rules for Schematron

docker run --rm -it \
-v $(pwd):/src \
-v $(pwd)/target/generated:/target \
klakegg/saxon \
-s:structure/espd-request/structure.xml \
-xsl:tools/xslt/structure-schematron.xslt \
-o:/target/EHF-ESPD-REQUEST-BASIC.sch \
pattern_only=true

docker run --rm -it \
-v $(pwd):/src \
-v $(pwd)/target/generated:/target \
klakegg/saxon \
-s:structure/espd-response/structure.xml \
-xsl:tools/xslt/structure-schematron.xslt \
-o:/target/EHF-ESPD-RESPONSE-BASIC.sch \
pattern_only=true