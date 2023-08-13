#!/bin/bash

echo "*** What do you want to clone today? ***"
echo ""
echo "########################################"
echo "#                                      #"
echo "#  (1)   dxvk                          #"
echo "#  (2)   dxvk-ags                      #"
echo "#  (3)   dxvk-nvapi                    #"
echo "#  (4)   d8vk                          #"
echo "#  (5)   dxvk-tests                    #"
echo "#  (6)   vkd3d-proton                  #"
echo "#                                      #"
echo "########################################"
echo ""
read -p ">>> Pick an option and press ENTER: " REPO_NAME

echo ""
read -p ">>> What branch will it be?: " BRANCH
echo ""

case $REPO_NAME in
    2)
        rm -rf dxvk-ags
        git clone --recurse-submodules https://github.com/doitsujin/dxvk-ags --branch $BRANCH dxvk-ags
        echo -e "/package-release.sh\n/.gitignore" >> dxvk-ags/.gitignore
        cp ../misc/package-release_dxvk-ags.sh dxvk-ags/package-release.sh
        ;;
    3)
        rm -rf dxvk-nvapi
        git clone --recurse-submodules https://github.com/jp7677/dxvk-nvapi --branch $BRANCH dxvk-nvapi
        ;;
    4)
        rm -rf d8vk
        git clone --recurse-submodules https://github.com/AlpyneDreams/d8vk --branch $BRANCH d8vk
        ;;
    5)
        rm -rf dxvk-tests
        git clone --recurse-submodules https://github.com/doitsujin/dxvk-tests --branch $BRANCH dxvk-tests
        echo -e "/package-release.sh\n/.gitignore" >> dxvk-tests/.gitignore
        cp ../misc/package-release_dxvk-tests.sh dxvk-tests/package-release.sh
        ;;
    6)
        rm -rf vkd3d-proton
        git clone --recurse-submodules https://github.com/HansKristian-Work/vkd3d-proton --branch $BRANCH vkd3d-proton
        ;;
    *)
        rm -rf dxvk
        git clone --recurse-submodules https://github.com/doitsujin/dxvk --branch $BRANCH dxvk
        ;;
esac

