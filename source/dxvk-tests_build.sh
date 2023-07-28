#!/bin/bash

BASE_FOLDER="dxvk-tests"
BUILD_DIR=$BASE_FOLDER"/build"

DXVKTESTS_SRC_DIR=$(dirname $(readlink -f $0))"/$BASE_FOLDER"
DXVKTESTS_BUILD_DIR=$(realpath "$BUILD_DIR")

# won't ever be a problem with docker builds
#if [ -e "$DXVKTESTS_BUILD_DIR" ]; then
#  echo "Clearing existing build directory $DXVKTESTS_BUILD_DIR"
#  rm -rf "$DXVKTESTS_BUILD_DIR"
#fi

function build_arch {
  cd "$DXVKTESTS_SRC_DIR"

  meson setup --cross-file "$DXVKTESTS_SRC_DIR/build-win$1.txt" \
              --buildtype "release"                             \
              --prefix "$DXVKTESTS_BUILD_DIR"                   \
              --strip                                           \
              --bindir "x$1"                                    \
              --libdir "x$1"                                    \
              "$DXVKTESTS_BUILD_DIR/build.$1"

  cd "$DXVKTESTS_BUILD_DIR/build.$1"
  ninja install

  rm -rf "$DXVKTESTS_BUILD_DIR/build.$1"
}

echo "Building x86-32 tests..."
build_arch 32
echo ""
echo "Building x86-64 tests..."
build_arch 64
echo ""

if [ $? -eq 0 ]
then
    rm -rf /home/builder/output/$BASE_FOLDER
    mv /home/builder/source/$BASE_FOLDER/build /home/builder/output/$BASE_FOLDER    
fi

rm -rf /home/builder/source/$BASE_FOLDER/build

