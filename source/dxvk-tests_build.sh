#!/bin/bash

BASE_FOLDER="dxvk-tests"
BUILD_DIR=$BASE_FOLDER"/build"
crossfile=""

DXVKTESTS_SRC_DIR=$(dirname $(readlink -f $0))"/$BASE_FOLDER"
DXVKTESTS_BUILD_DIR=$(realpath "$BUILD_DIR")

if [ -e "$DXVKTESTS_BUILD_DIR" ]; then
  echo "Clearing existing build directory $DXVKTESTS_BUILD_DIR"
  rm -rf "$DXVKTESTS_BUILD_DIR"
fi

function build_arch {
  cd "$DXVKTESTS_SRC_DIR"

  meson setup --cross-file "$DXVKTESTS_SRC_DIR/build-win$1.txt" \
              --buildtype "release"                             \
              --prefix "$DXVKTESTS_BUILD_DIR"                   \
              --strip                                           \
              --bindir "x$1"                                    \
              --libdir "x$1"                                    \
              "$DXVKTESTS_BUILD_DIR/build.$1"

  echo "*" > "$DXVKTESTS_BUILD_DIR/../.gitignore"

  cd "$DXVKTESTS_BUILD_DIR/build.$1"
  ninja install
}

build_arch 32

if [ $? -eq 0 ]
then
	rm -rf /home/builder/output/$BASE_FOLDER
    mv /home/builder/source/$BASE_FOLDER/build/x32 /home/builder/output/$BASE_FOLDER
	rm -rf /home/builder/source/$BASE_FOLDER/build
fi

