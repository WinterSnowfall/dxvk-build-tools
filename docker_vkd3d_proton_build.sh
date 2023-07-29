#!/bin/bash

docker system prune -f
docker pull archlinux:latest

cd dockerfile_vkd3d-proton
docker build -t archlinux/vkd3d-proton .
cd ..

