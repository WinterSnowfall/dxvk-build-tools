#!/bin/bash

SOURCE_PATH=$PWD/source
OUTPUT_PATH=$PWD/output
BUILD_NAME=devel
# update if you care about file timestamps
TIMEZONE=Etc/UTC

if [ $# -ge 1 ]
then
    BUILD_NAME=$2
fi

if [ $DXVK_MAX_PERFORMANCE -eq 1 ]
then
    sed -i "s/\['-msse', '-msse2'\]$/\['-march=native'\]/g" $SOURCE_PATH/vkd3d-proton/build-win32.txt
    sed -i "/\['-march=native'\]/d" $SOURCE_PATH/vkd3d-proton/build-win64.txt
    sed -i "s/\[properties\]$/\[properties\]\nc_args=\['-march=native'\]\ncpp_args=\['-march=native'\]/g" $SOURCE_PATH/vkd3d-proton/build-win64.txt
fi

docker run -ti --rm \
           --name vkd3d-proton-builder \
           -h vkd3d-proton-builder  \
           -e TZ="$TIMEZONE" \
           -e PROJECT_NAME=vkd3d-proton \
           -e BUILD_NAME="$BUILD_NAME" \
           -v $SOURCE_PATH:/home/builder/source \
           -v $OUTPUT_PATH:/home/builder/output \
           archlinux/vkd3d-proton

