#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..
. $FOLDER/tools/script/common.sh

info "Generate Criteria Taxonomy artifacts"

echo " * Generate Schematron"
docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:structure/codelist/CriteriaTaxonomy.xml \
-xsl:tools/xslt/CriteriaTaxonomy-schematron.xslt \
-o:/target/CriteriaTaxonomy.sch \
pattern_only=true

echo " * Generate snippet file"
docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:structure/codelist/CriteriaTaxonomy.xml \
-xsl:tools/xslt/CriteriaTaxonomy-snippet.xslt \
-o:/target/CriteriaTaxonomy-snippet.xml

echo " * Generate rule file"
docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:target/generated/CriteriaTaxonomy.sch \
-xsl:tools/xslt/CriteriaTaxonomy-structure.xslt \
-o:/target/CriteriaTaxonomy.xml

echo " * Generate documentation"
docker run --rm -i \
-v $FOLDER:/src \
alpine:3.6 \
sh /src/tools/script/CriteriaTaxonomy-adoc.sh

info "Prepare zip containing XSD files"
docker run --rm -i \
-v $FOLDER/espd-edm/exchange-model/src/main/resources/schema:/espd-1.0.2-schema \
-v $FOLDER/target/generated:/target \
kramos/alpine-zip \
-x espd-1.0.2-schema/maindoc/bindings.xjb -r /target/schema.zip /espd-1.0.2-schema

info "Prepare Schematron"

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/schematron \
prepare rules/sch/EHF-ESPD-REQUEST.sch /target/EHF-ESPD-REQUEST.sch

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/schematron \
prepare rules/sch/EHF-ESPD-RESPONSE.sch /target/EHF-ESPD-RESPONSE.sch

info "Run vefa-structure"
docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target:/target \
difi/vefa-structure:0.5

info "Build and verify validation artifacts"
docker run --rm -i \
-v $FOLDER:/src \
difi/vefa-validator \
build -x -t /src -t -target target/validator -n no.difi.ehf.espd
