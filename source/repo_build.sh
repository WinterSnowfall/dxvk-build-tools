#!/bin/bash

if [ $# -gt 0 ]
then
    REPO_NAME="$1"
    BUILD_NAME="$2"

    case "$REPO_NAME" in
        "dxvk"|"d8vk")
            BUILD_BASE_PATH="dxvk"
            ;;
        "dxvk-ags")
            BUILD_BASE_PATH="dxvk-ags"
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
        "nvidia-libs")
            BUILD_BASE_PATH="nvidia-libs"
            ;;
        *)
            echo "Invalid repository name selection."
            exit 1
            ;;
    esac

    cd "$REPO_NAME"
    ./package-release.sh "$BUILD_NAME" /home/builder --no-package

    if [ $? -eq 0 ]
    then
        if [ "$REPO_NAME" == "dxvk-ags" ]
        then
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/x64/amd_ags_x64.dll.a"
        elif [ "$REPO_NAME" == "dxvk-nvapi" ]
        then
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/LICENSE"
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/README.md"
        elif [ "$REPO_NAME" == "vkd3d-proton" ]
        then
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/setup_vkd3d_proton.sh"
        elif [ "$REPO_NAME" == "nvidia-libs" ]
        then
            mv "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/lib/wine/i386-windows" "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/x32"
            mv "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/lib64/wine/x86_64-windows" "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/x64"
            mv -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/lib/wine/i386-unix/nvcuda.dll.so" "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/x32/nvcuda.dll"
            mv -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/lib64/wine/x86_64-unix/nvcuda.dll.so" "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/x64/nvcuda.dll"
            mv -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/lib64/wine/x86_64-unix/nvoptix.dll.so" "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/x64/nvoptix.dll"
            rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/bin"
            rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/lib"
            rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/lib64"
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/nvml_setup.sh"
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/proton_setup.sh"
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/Readme_nvml.txt"
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/setup_nvlibs.sh"
            rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/version"
        fi

        rm -rf "/home/builder/output/$REPO_NAME-$BUILD_NAME"
        mv "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME" "/home/builder/output/$REPO_NAME-$BUILD_NAME"
    else
        rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME"
    fi
    
    cd ..
else
    echo "Please specify the repository name!"
    exit 2
fi

