#!/bin/sh

if [ -e /target/site ]; then
    mv /target/guide/* /target/site/
    rm -r /target/guide
fi