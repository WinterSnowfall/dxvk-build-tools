#!/bin/bash

SOURCE_PATH=$PWD/source
OUTPUT_PATH=$PWD/output
BUILD_NAME=devel
# update if you care about file timestamps
TIMEZONE=Etc/UTC

if [ $# -ge 1 ]
then
    if [ $# -ge 2 ]
    then
        BUILD_NAME=$2
    fi
    docker run -ti --rm \
               --name dxvk-builder \
               -h dxvk-builder  \
               -e TZ="$TIMEZONE" \
               -e PROJECT_NAME="$1" \
               -e BUILD_NAME="$BUILD_NAME" \
               -v $SOURCE_PATH:/home/builder/source \
               -v $OUTPUT_PATH:/home/builder/output \
               archlinux/dxvk
else
    echo "Please specify the project name!"
fi

