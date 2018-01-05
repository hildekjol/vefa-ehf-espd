#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..

# Generate CriteriaTaxonomy rules for Schematron

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:structure/codelist/CriteriaTaxonomy.xml \
-xsl:tools/xslt/CriteriaTaxonomy-schematron.xslt \
-o:/target/CriteriaTaxonomy.sch \
pattern_only=true

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:structure/codelist/CriteriaTaxonomy.xml \
-xsl:tools/xslt/CriteriaTaxonomy-snippet.xslt \
-o:/target/CriteriaTaxonomy-snippet.xml

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:target/generated/CriteriaTaxonomy.sch \
-xsl:tools/xslt/CriteriaTaxonomy-structure.xslt \
-o:/target/CriteriaTaxonomy.xml

docker run --rm -i -v $FOLDER:/src alpine:3.6 sh /src/tools/script/CriteriaTaxonomy-adoc.sh

# Prepare zip containing XSD files

docker run --rm -i \
-v $FOLDER/espd-edm/exchange-model/src/main/resources/schema:/espd-1.0.2-schema \
-v $FOLDER/target/generated:/target \
kramos/alpine-zip \
-x espd-1.0.2-schema/maindoc/bindings.xjb -r /target/schema.zip /espd-1.0.2-schema

# Run vefa-structure

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target:/target \
difi/vefa-structure:0.5

# Validator build

docker run --rm -i \
-v $FOLDER:/src \
difi/vefa-validator \
build -x -t /src -t -target target/validator -n no.difi.ehf.espd
