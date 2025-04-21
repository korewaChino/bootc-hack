container := "docker.io/korewachino/bootc-test"
test_img := "test.img"
podman := "sudo podman"

build:
    {{podman}} build --tag {{container}} .

shell: build
    {{podman}} run --rm -it {{container}} bash

push: build
    {{podman}} push {{container}}

install: build
    {{podman}} run --rm -it \
        --mount type=bind,source=$(pwd)/,target=/work \
        --mount type=bind,source=/dev,target=/dev \
        --privileged \
        --pid=host \
        -e BOOTC_BOOTLOADER_DEBUG="-vvvv" \
        --cap-add=SYS_ADMIN \
        --device /dev/fuse \
        {{container}} \
        bootc install to-disk \
         --source-imgref containers-storage:{{container}} \
         --skip-fetch-check \
         --filesystem ext4 \
         --via-loopback \
         --wipe \
         /work/{{test_img}}   

bootc-install:
    sudo bootc install to-disk \
     --via-loopback \
     --source-imgref containers-storage:{{container}} \
     --skip-fetch-check \
     --filesystem ext4 \
     --wipe \
     {{test_img}}

vm:
    qemu-kvm \
        -m 4G \
        -cpu host \
        -smp 4 \
        -bios /usr/share/OVMF/OVMF_CODE.fd \
        -drive file={{test_img}},format=raw \
        -vga qxl