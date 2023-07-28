FROM archlinux:latest

RUN pacman -Syu --noconfirm && pacman -S --noconfirm \
    mingw-w64-gcc \
    meson \
    glslang \
    && useradd -m builder

USER builder

WORKDIR /home/builder/source

ENV PROJECT_NAME=dxvk
ENV BUILD_NAME=devel
    
CMD ["bash", "-c", "/home/builder/source/dxvk_build_branch.sh $PROJECT_NAME $BUILD_NAME"]

