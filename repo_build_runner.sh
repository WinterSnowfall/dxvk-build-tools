#!/bin/bash

SOURCE_PATH="$PWD/source"
OUTPUT_PATH="$PWD/output"
MISC_PATH="$PWD/misc"
BUILD_NAME="devel"
# update if you care about file timestamps
TIMEZONE="Etc/UTC"

if [ $# -ge 1 ]
then
    REPO_NAME="$1"

    if [ $# -ge 2 ]
    then
        BUILD_NAME="$2"
    fi

    docker run -ti --rm \
               --name dxvk-builder \
               -h dxvk-builder \
               -e TZ="$TIMEZONE" \
               -e REPO_NAME="$REPO_NAME" \
               -e BUILD_NAME="$BUILD_NAME" \
               -v "$SOURCE_PATH":/home/builder/source \
               -v "$OUTPUT_PATH":/home/builder/output \
               -v "$MISC_PATH":/home/builder/misc \
               dxvk-builder
else
    echo "Please specify the repository name!"
    exit 1
fi

