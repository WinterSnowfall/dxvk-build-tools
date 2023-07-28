#!/bin/bash

SOURCE_PATH=$PWD/source
OUTPUT_PATH=$PWD/output
# update if you care about file timestamps
TIMEZONE=Etc/UTC

docker run -ti --rm \
           --name dxvk-tests-builder \
           -h dxvk-tests-builder  \
           -e TZ="$TIMEZONE" \
           -v $SOURCE_PATH:/home/builder/source \
           -v $OUTPUT_PATH:/home/builder/output \
           archlinux/dxvk-tests

