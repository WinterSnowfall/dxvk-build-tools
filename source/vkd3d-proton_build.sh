#!/bin/bash

if [ $# -gt 0 ]
then
    rm -rf /home/builder/vkd3d-proton-$2
    ./$1/package-release.sh $2 /home/builder --no-package
    if [ $? -eq 0 ]
    then
        rm -rf /home/builder/output/$1-$2
        rm -rf /home/builder/vkd3d-proton-$2/setup_vkd3d_proton.sh
        mv /home/builder/vkd3d-proton-$2 /home/builder/output/$1-$2
    else
        rm -rf /home/builder/vkd3d-proton-$2
    fi
else
    echo "Please specify branch name to build!"
fi

