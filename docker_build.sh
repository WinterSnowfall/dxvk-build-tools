#!/bin/bash

docker rmi archlinux/dxvk-builder > /dev/null 2>&1
docker pull archlinux:latest

cd dockerfile
docker build -t archlinux/dxvk-builder .
cd ..

