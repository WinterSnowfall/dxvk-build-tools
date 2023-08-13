#!/bin/bash

set -e

shopt -s extglob

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 version destdir [--no-package] [--dev-build]"
  exit 1
fi

DXVKAGS_VERSION="$1"
DXVKAGS_SRC_DIR=$(readlink -f "$0")
DXVKAGS_SRC_DIR=$(dirname "$DXVKAGS_SRC_DIR")
DXVKAGS_BUILD_DIR=$(realpath "$2")"/dxvk-ags-$DXVKAGS_VERSION"
DXVKAGS_ARCHIVE_PATH=$(realpath "$2")"/dxvk-ags-$DXVKAGS_VERSION.tar.gz"

if [ -e "$DXVKAGS_BUILD_DIR" ]; then
  echo "Build directory $DXVKAGS_BUILD_DIR already exists"
  exit 1
fi

shift 2

opt_nopackage=0
opt_devbuild=0
opt_buildid=false

crossfile="build-win"

while [ $# -gt 0 ]; do
  case "$1" in
  "--no-package")
    opt_nopackage=1
    ;;
  "--dev-build")
    opt_nopackage=1
    opt_devbuild=1
    ;;
  "--build-id")
    opt_buildid=true
    ;;
  *)
    echo "Unrecognized option: $1" >&2
    exit 1
  esac
  shift
done

function build_arch {
  cd "$DXVKAGS_SRC_DIR"

  opt_strip=
  if [ $opt_devbuild -eq 0 ]; then
    opt_strip=--strip
  fi

  meson setup --cross-file "$DXVKAGS_SRC_DIR/$crossfile$1.txt" \
              --buildtype "release"                              \
              --prefix "$DXVKAGS_BUILD_DIR"                    \
              $opt_strip                                         \
              --bindir "x$1"                                     \
              --libdir "x$1"                                     \
              "$DXVKAGS_BUILD_DIR/build.$1"

  cd "$DXVKAGS_BUILD_DIR/build.$1"
  ninja install

  if [ $opt_devbuild -eq 0 ]; then
      rm -rf "$DXVKAGS_BUILD_DIR/build.$1"
  fi
}

function package {
  cd "$DXVKAGS_BUILD_DIR/.."
  tar -czf "$DXVKAGS_ARCHIVE_PATH" "dxvk-$DXVKAGS_VERSION"
  rm -R "dxvk-$DXVKAGS_VERSION"
}

build_arch 64

if [ $opt_nopackage -eq 0 ]; then
  package
fi

