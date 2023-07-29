FROM archlinux:latest

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
    && pacman -Syu --noconfirm && pacman -S --noconfirm \
    mingw-w64-gcc \
    meson \
    glslang \
    wine \
    git \
    && useradd -m builder

USER builder

WORKDIR /home/builder/source

ENV PROJECT_NAME=vkd3d-proton
ENV BUILD_NAME=devel

CMD ["bash", "-c", "/home/builder/source/vkd3d-proton_build.sh $PROJECT_NAME $BUILD_NAME"]

