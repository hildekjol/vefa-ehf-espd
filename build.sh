#!/bin/sh

info() {
    echo "\n  *** $1 ***\n"
}

# Delete old target folder if found.
if [ -d target ]; then rm -rf target; fi

info "Generate structure"
sh tools/travis/structure.sh

info "Generate validation artifacts"
sh tools/travis/rules.sh

info "Generate documentation"
sh tools/travis/guides.sh

info "Fix ownership"
docker run --rm -it -v $(pwd):/src alpine:3.6 chown -R $(id -g $USER).$(id -g $USER) /src/target
