#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..

# Generate basic rules for Schematron

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:structure/espd-request/structure.xml \
-xsl:tools/xslt/structure-schematron.xslt \
-o:/target/EHF-ESPD-REQUEST-BASIC.sch \
pattern_only=true

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:structure/espd-response/structure.xml \
-xsl:tools/xslt/structure-schematron.xslt \
-o:/target/EHF-ESPD-RESPONSE-BASIC.sch \
pattern_only=true

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:codelist/CriteriaTaxonomy.xml \
-xsl:tools/xslt/CriteriaTaxonomy-schematron.xslt \
-o:/target/CriteriaTaxonomy.sch \
pattern_only=true

# Validator build

docker run --rm -i -v $FOLDER:/src difi/vefa-validator build -x -t /src -t -target target/validator
