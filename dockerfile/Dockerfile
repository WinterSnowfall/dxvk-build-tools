FROM archlinux:latest

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
    && pacman -Syu --noconfirm && pacman -S --noconfirm \
    mingw-w64-gcc \
    meson \
    glslang \
    wine \
    git
RUN useradd -m builder \
    && chmod 777 /home/builder

USER builder

WORKDIR /home/builder/source

ENV REPO_NAME=dxvk
ENV BUILD_NAME=devel
    
CMD ["bash", "-c", "/home/builder/source/repo_build.sh $REPO_NAME $BUILD_NAME"]

