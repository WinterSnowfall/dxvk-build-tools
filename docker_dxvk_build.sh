#!/bin/bash

docker system prune -f
docker pull archlinux:latest

cd dockerfile_dxvk
docker build -t archlinux/dxvk .
cd ..

