#!/bin/bash

# switch to false if you'd rather clone the repos yourself
GIT_CLONE=true

if [ $# -gt 0 ]
then
    REPO_NAME="$1"
    BUILD_NAME="$2"
    BUILD_VARIANT="$3"

    if [ "$BUILD_VARIANT" != "default" ]
    then
        BUILD_NAME="$2-$3"
    fi

    case "$REPO_NAME" in
        "dxvk")
            BUILD_BASE_PATH="dxvk"
            REPO_URL="https://github.com/doitsujin/dxvk"
            ;;
        "dxvk-ags")
            BUILD_BASE_PATH="dxvk-ags"
            REPO_URL="https://github.com/doitsujin/dxvk-ags"
            ;;
        "dxvk-nvapi")
            BUILD_BASE_PATH="dxvk-nvapi"
            REPO_URL="https://github.com/jp7677/dxvk-nvapi"
            ;;
        "dxvk-tests")
            BUILD_BASE_PATH="dxvk-tests"
            REPO_URL="https://github.com/doitsujin/dxvk-tests"
            ;;
        "d8vk-tests")
            BUILD_BASE_PATH="dxvk-tests"
            REPO_URL="https://github.com/WinterSnowfall/d8vk-tests"
            ;;
        "vkd3d-proton")
            BUILD_BASE_PATH="vkd3d-proton"
            REPO_URL="https://github.com/HansKristian-Work/vkd3d-proton"
            ;;
        "nvidia-libs")
            BUILD_BASE_PATH="nvidia-libs"
            REPO_URL="https://github.com/SveSop/nvidia-libs"
            ;;
        *)
            echo "Invalid repository name selection."
            exit 1
            ;;
    esac

    if $GIT_CLONE
    then
        git clone --depth 1 --recurse-submodules "$REPO_URL" "$REPO_NAME"

        if [ "$REPO_NAME" == "dxvk-ags" ]
        then
            echo -e "/package-release.sh\n/.gitignore" >> dxvk-ags/.gitignore
            cp ../misc/package-release_dxvk-ags.sh dxvk-ags/package-release.sh
        elif [ "$REPO_NAME" == "dxvk-tests" ]
        then
            echo -e "/package-release.sh\n/.gitignore" >> dxvk-tests/.gitignore
            cp ../misc/package-release_dxvk-tests.sh dxvk-tests/package-release.sh
        elif [ "$REPO_NAME" == "d8vk-tests" ]
        then
            echo -e "/package-release.sh\n/meson.build.xp\n/.gitignore" >> d8vk-tests/.gitignore
            cp ../misc/package-release_dxvk-tests.sh d8vk-tests/package-release.sh
            cp ../misc/meson_d8vk-tests-xp.build d8vk-tests/meson.build.xp
        fi
    fi

    if [ -d "$REPO_NAME" ]
    then
        cd "$REPO_NAME"

        if [ "$REPO_NAME" == "d8vk-tests" -a "$BUILD_VARIANT" == "xp" ]
        then
            mv meson.build meson.build.bak
            mv meson.build.xp meson.build
        fi

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
                rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/bin"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/bottles_setup.sh"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/nvml_setup.sh"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/package-release.sh"
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

        if [ "$REPO_NAME" == "d8vk-tests" -a "$BUILD_VARIANT" == "xp" ]
        then
            mv meson.build meson.build.xp
            mv meson.build.bak meson.build
        fi

        cd ..
        # comment if you'd rather keep the cloned repos around after building
        rm -rf "$REPO_NAME"
    else
        echo "Specified repository folder does not exist!"
        exit 2
    fi
else
    echo "Please specify the repository name!"
    exit 3
fi

