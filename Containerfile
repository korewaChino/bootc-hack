FROM fedora:42

RUN dnf install -y \
    ostree \
    bootc \
    kernel \
    dracut \
    dracut-live \
    e2fsprogs \
    dosfstools \
    btrfs-progs \
    xfsprogs \
    bootupd \
    grub2 \
    grub2-efi \
    shim \
    grub2-efi-x64 \
    grub2-efi-x64-modules \
    grub2-pc-modules \
    grub2-tools-efi \
    grub2-tools

RUN mkdir -p /sysroot/ostree/repo /usr/lib/ostree
COPY prepare-root.conf /usr/lib/ostree/prepare-root.conf
LABEL containers.bootc=1