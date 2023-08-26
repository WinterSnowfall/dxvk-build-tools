#!/bin/bash

docker rmi dxvk-builder:latest > /dev/null 2>&1
docker pull archlinux:latest

cd dockerfile
docker build -t dxvk-builder:latest .
cd ..

