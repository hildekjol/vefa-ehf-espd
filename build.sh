#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))

info() {
    echo "\n  *** $1 ***\n"
}

# Delete old target folder if found.
if [ -d target ]; then rm -rf target; fi

info "Generate structure"
sh $FOLDER/tools/travis/structure.sh

info "Generate validation artifacts"
sh $FOLDER/tools/travis/rules.sh

info "Generate documentation"
sh $FOLDER/tools/travis/guides.sh

info "Fix ownership"
docker run --rm -i -v $FOLDER:/src alpine:3.6 chown -R $(id -g $USER).$(id -g $USER) /src/target
