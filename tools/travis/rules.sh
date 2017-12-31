#!/bin/sh

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

# Validator build

docker run --rm -it -v $(pwd):/src difi/vefa-validator build -x -t /src -t -target target/validator
