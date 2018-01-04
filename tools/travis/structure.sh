#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/generated:/target \
klakegg/saxon \
-s:codelist/CriteriaTaxonomy.xml \
-xsl:tools/xslt/CriteriaTaxonomy-schematron.xslt \
-o:/target/CriteriaTaxonomy.sch \
pattern_only=true

docker run --rm -i \
-v $FOLDER:/src \
-v $FOLDER/target/structure:/target \
difi/vefa-structure:0.5
