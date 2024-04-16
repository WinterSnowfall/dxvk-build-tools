FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    mingw-w64 \
    python3-pip \
    wine-stable \
    git
RUN pip3 install meson ninja
RUN useradd -m builder \
    && chmod 777 /home/builder

USER builder

WORKDIR /home/builder/source

ENV REPO_NAME="dxvk"
ENV BUILD_NAME="devel"
    
CMD ["bash", "-c", "/home/builder/source/repo_build.sh \"$REPO_NAME\" \"$BUILD_NAME\""]

