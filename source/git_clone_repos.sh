#!/bin/bash

echo "*** What do you want to clone today? ***"
echo ""
echo "########################################"
echo "#                                      #"
echo "#  (1)   dxvk                          #"
echo "#  (2)   d8vk                          #"
echo "#  (3)   dxvk-tests                    #"
echo "#                                      #"
echo "########################################"
echo ""
read -p ">>> Pick an option and press ENTER: " PROJECT

echo ""
read -p ">>> What branch will it be?: " BRANCH
echo ""

case $PROJECT in
    2)
        rm -rf d8vk
        git clone --recurse-submodules https://github.com/AlpyneDreams/d8vk --branch $BRANCH d8vk
        ;;
    3)
        rm -rf dxvk-tests
        git clone --recurse-submodules https://github.com/doitsujin/dxvk-tests --branch $BRANCH dxvk-tests
        ;;
    *)
        rm -rf dxvk
	    git clone --recurse-submodules https://github.com/doitsujin/dxvk --branch $BRANCH dxvk
        ;;
esac

