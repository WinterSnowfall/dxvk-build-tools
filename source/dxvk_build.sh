#!/bin/bash

if [ $# -gt 0 ]
then
    rm -rf /home/builder/dxvk-$2
    ./$1/package-release.sh $2 /home/builder --no-package
    if [ $? -eq 0 ]
    then
        rm -rf /home/builder/output/$1-$2
        mv /home/builder/dxvk-$2 /home/builder/output/$1-$2
    else
        rm -rf /home/builder/dxvk-$2
    fi
else
    echo "Please specify branch name to build!"
fi

