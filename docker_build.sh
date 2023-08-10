#!/bin/bash

docker system prune -f
docker pull archlinux:latest

cd dockerfile
docker build -t archlinux/repo-builder .
cd ..

