#!/bin/bash

docker rmi dxvk-builder:sniper 2>/dev/null
docker pull registry.gitlab.steamos.cloud/steamrt/sniper/sdk

cd dockerfile-sniper
docker build -t dxvk-builder:sniper .
cd ..

