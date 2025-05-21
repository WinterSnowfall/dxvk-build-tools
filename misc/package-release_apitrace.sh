#!/bin/bash

git clone https://github.com/apitrace/dxsdk

cmake -DCMAKE_SYSTEM_NAME=Windows \
      -DCMAKE_SYSTEM_PROCESSOR=i686 \
      -DCMAKE_INCLUDE_PATH=./dxsdk \
      -DCMAKE_C_COMPILER=/usr/bin/i686-w64-mingw32-gcc \
      -DCMAKE_CXX_COMPILER=/usr/bin/i686-w64-mingw32-g++ \
      -DCMAKE_CXX_FLAGS="-s -static -static-libgcc -static-libstdc++ -msse -msse2 -mfpmath=sse -mpreferred-stack-boundary=2 -Wl,--file-alignment=4096 -Wl,--enable-stdcall-fixup -Wl,--kill-at" \
      -DENABLE_GUI=FALSE \
       CMakeLists.txt
make clean
make -j "$(nproc)"

mkdir -p ../../apitrace-$1/x32/bin
mkdir -p ../../apitrace-$1/x32/wrappers
mv apitrace.exe ../../apitrace-$1/x32/bin
mv d3dretrace.exe ../../apitrace-$1/x32/bin
mv glretrace.exe ../../apitrace-$1/x32/bin
find wrappers -name "*.dll" -exec mv {} ../../apitrace-$1/x32/wrappers \;

git clean -x -d -f -e package-release.sh

cmake -DCMAKE_SYSTEM_NAME=Windows \
      -DCMAKE_SYSTEM_PROCESSOR=x86_64 \
      -DCMAKE_INCLUDE_PATH=./dxsdk \
      -DCMAKE_C_COMPILER=/usr/bin/x86_64-w64-mingw32-gcc \
      -DCMAKE_CXX_COMPILER=/usr/bin/x86_64-w64-mingw32-g++ \
      -DCMAKE_CXX_FLAGS="-s -static -static-libgcc -static-libstdc++ -msse -msse2 -mfpmath=sse -Wl,--file-alignment=4096" \
      -DENABLE_GUI=FALSE \
       CMakeLists.txt
make clean
make -j "$(nproc)"

mkdir -p ../../apitrace-$1/x64/bin
mkdir -p ../../apitrace-$1/x64/wrappers
mv apitrace.exe ../../apitrace-$1/x64/bin
mv d3dretrace.exe ../../apitrace-$1/x64/bin
mv glretrace.exe ../../apitrace-$1/x64/bin
find wrappers -name "*.dll" -exec mv {} ../../apitrace-$1/x64/wrappers \;

git clean -x -d -f -e package-release.sh

rm -rf dxsdk

