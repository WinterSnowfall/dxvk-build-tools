#!/bin/bash

docker rmi dxvk-builder:xp > /dev/null 2>&1
docker pull ubuntu:20.04

cd dockerfile-xp
docker build -t dxvk-builder:xp .
cd ..

