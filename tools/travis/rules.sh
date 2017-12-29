#!/bin/sh

# Validator build

docker run --rm -it -v $(pwd):/src difi/vefa-validator build -x -t /src -t -target target/validator
