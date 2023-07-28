FROM archlinux:latest

RUN pacman -Syu --noconfirm && pacman -S --noconfirm \
    mingw-w64-gcc \
    meson \
    glslang \
    && useradd -m builder

USER builder

WORKDIR /home/builder/source
    
CMD ["bash", "-c", "/home/builder/source/dxvk-tests_build.sh"]

