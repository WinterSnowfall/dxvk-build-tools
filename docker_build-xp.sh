#!/bin/bash

docker rmi dxvk-builder:xp 2>/dev/null
docker pull debian:bullseye

cd dockerfile-xp
docker build -t dxvk-builder:xp .
cd ..

