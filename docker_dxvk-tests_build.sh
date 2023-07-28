#!/bin/bash

docker system prune -f
docker pull archlinux:latest

cd dockerfile_dxvk-tests
docker build -t archlinux/dxvk-tests .
cd ..

