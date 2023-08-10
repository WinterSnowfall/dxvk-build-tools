#!/bin/bash

if [ $# -gt 0 ]
then
    REPO_NAME="$1"
    BUILD_NAME="$2"

    case $REPO_NAME in
        "dxvk"|"d8vk")
            BUILD_BASE_PATH="dxvk"
            ;;
        "dxvk-nvapi")
            BUILD_BASE_PATH="dxvk-nvapi"
            ;;
        "dxvk-tests")
            BUILD_BASE_PATH="dxvk-tests"
            ;;
        "vkd3d-proton")
            BUILD_BASE_PATH="vkd3d-proton"
            ;;
        *)
            echo "Invalid repository name selection."
            exit 1
            ;;
    esac

    cd $REPO_NAME
    ./package-release.sh $BUILD_NAME /home/builder --no-package

    if [ $? -eq 0 ]
    then
        if [ $REPO_NAME == "dxvk-nvapi" ]
        then
            rm -f /home/builder/$BUILD_BASE_PATH-$BUILD_NAME/LICENSE
            rm -f /home/builder/$BUILD_BASE_PATH-$BUILD_NAME/README.md
        elif [ $REPO_NAME == "vkd3d-proton" ]
        then
            rm -f /home/builder/$BUILD_BASE_PATH-$BUILD_NAME/setup_vkd3d_proton.sh
        fi

        rm -rf /home/builder/output/$REPO_NAME-$BUILD_NAME
        mv /home/builder/$BUILD_BASE_PATH-$BUILD_NAME /home/builder/output/$REPO_NAME-$BUILD_NAME
    else
        rm -rf /home/builder/$BUILD_BASE_PATH-$BUILD_NAME
    fi
    
    cd ..
else
    echo "Please specify the repository name!"
fi

