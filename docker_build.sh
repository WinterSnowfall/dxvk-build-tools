#!/bin/bash

docker rmi dxvk-builder:latest 2>/dev/null
docker pull archlinux:latest

cd dockerfile
docker build -t dxvk-builder:latest .
cd ..

