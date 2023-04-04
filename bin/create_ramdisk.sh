#!/bin/bash

sudo dd if=/dev/zero of=ramdisk bs=1M count=96

sudo mkfs.ext4 ramdisk

mkdir -p /tmp/ramdisk

sudo mount ramdisk /tmp/ramdisk -o loop

sudo tar -xvpf rootfs.tar -C /tmp/ramdisk

sudo umount /tmp/ramdisk

gzip -f -9 ramdisk

mkimage -f fit-kernel-full.its image.ub.ramfs

exit 0