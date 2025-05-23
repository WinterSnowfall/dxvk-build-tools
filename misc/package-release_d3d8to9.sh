#!/bin/bash

cmake -DCMAKE_SYSTEM_NAME=Windows \
      -DCMAKE_SYSTEM_PROCESSOR=i686 \
      -DCMAKE_CXX_COMPILER=/usr/bin/i686-w64-mingw32-g++ \
      -DCMAKE_CXX_FLAGS="-s -static -static-libgcc -static-libstdc++ -msse -msse2 -mfpmath=sse -mpreferred-stack-boundary=2 -Wl,--file-alignment=4096 -Wl,--enable-stdcall-fixup -Wl,--kill-at" \
       CMakeLists.txt
make clean
make -j "$(nproc)"

mkdir ../../d3d8to9-$1
mv d3d8.dll ../../d3d8to9-$1

git clean -x -d -f -e package-release.sh

