#!/bin/bash

# switch to false if you'd rather clone the repos yourself
GIT_CLONE=true

if [ $# -gt 0 ]
then
    REPO_NAME="$1"
    BUILD_NAME="$2"
    BUILD_TYPE="$3"
    BUILD_VARIANT="$4"

    if [ "$BUILD_TYPE" == "native" ]
    then
        if [ "$BUILD_VARIANT" != "default" -a "$BUILD_VARIANT" != "sniper" ]
        then
            echo "Native builds must use either default or sniper docker images."
            exit 1
        fi

        case "$REPO_NAME" in
            "dxvk")
                if [ "$BUILD_VARIANT" == "sniper" ]
                then
                    BUILD_NAME="$4-$2"
                fi

                BUILD_BASE_PATH="dxvk-native"
                REPO_URL="https://github.com/doitsujin/dxvk"
                ;;
            *)
                echo "Invalid repository name selection."
                exit 2
                ;;
        esac
    else
        if [ "$BUILD_VARIANT" != "default" ]
        then
            BUILD_NAME="$2-$4"
        fi

        case "$REPO_NAME" in
            "dxvk")
                BUILD_BASE_PATH="dxvk"
                REPO_URL="https://github.com/doitsujin/dxvk"
                ;;
            "dxvk-sarek")
                BUILD_BASE_PATH="dxvk"
                REPO_URL="https://github.com/pythonlover02/DXVK-Sarek"
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
                exit 3
                ;;
        esac
    fi

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

        if [ "$BUILD_TYPE" == "native" ]
        then
            ./package-native.sh "$BUILD_NAME" /home/builder --no-package
        else
            ./package-release.sh "$BUILD_NAME" /home/builder --no-package
        fi

        if [ $? -eq 0 ]
        then
            if [ "$BUILD_BASE_PATH" == "dxvk-native" ]
            then
                rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/usr/include"
                rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/usr/lib/pkgconfig"
                rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/usr/lib32/pkgconfig"
            elif [ "$BUILD_BASE_PATH" == "dxvk-ags" ]
            then
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/x64/amd_ags_x64.dll.a"
            elif [ "$BUILD_BASE_PATH" == "dxvk-nvapi" ]
            then
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/LICENSE"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/README.md"
            elif [ "$BUILD_BASE_PATH" == "vkd3d-proton" ]
            then
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/setup_vkd3d_proton.sh"
            elif [ "$BUILD_BASE_PATH" == "nvidia-libs" ]
            then
                rm -rf "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/bin"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/bottles_setup.sh"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/nvml_setup.sh"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/proton_setup.sh"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/README.md"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/Readme_nvml.txt"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/setup_nvlibs.sh"
                rm -f "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME/version"
            fi

            if [ "$BUILD_TYPE" == "native" ]
            then
                rm -rf "/home/builder/output/$BUILD_BASE_PATH-$BUILD_NAME" 
                mv "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME" "/home/builder/output/$BUILD_BASE_PATH-$BUILD_NAME"
            else
                rm -rf "/home/builder/output/$REPO_NAME-$BUILD_NAME"
                mv "/home/builder/$BUILD_BASE_PATH-$BUILD_NAME" "/home/builder/output/$REPO_NAME-$BUILD_NAME"
            fi
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
        exit 5
    fi
else
    echo "Please specify the repository name!"
    exit 4
fi

