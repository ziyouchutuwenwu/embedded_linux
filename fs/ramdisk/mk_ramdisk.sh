#!/bin/bash

if [ ! -n "$1" ] ;then
    echo "usage: $0 ROOTFS_DIR RAMDISK_SIZE OUTPUT_DIR"
    echo "please input ROOTFS_DIR"
    exit 1
fi

if [ ! -n "$2" ] ;then
    echo "usage: $0 ROOTFS_DIR RAMDISK_SIZE OUTPUT_DIR"
    echo "please input RAMDISK_SIZE"
    exit 1
fi

if [ ! -n "$3" ] ;then
    echo "usage: $0 ROOTFS_DIR RAMDISK_SIZE OUTPUT_DIR"
    echo "please input OUTPUT_DIR"
    exit 1
fi

ROOTFS_DIR=$1
RAMDISK_SIZE=$2
OUTPUT_DIR=$3

sudo chown -R root $ROOTFS_DIR
sudo chgrp -R root $ROOTFS_DIR

sudo dd if=/dev/zero of=ramdisk bs=1k count=$RAMDISK_SIZE
sudo mke2fs -F -v -m0 ./ramdisk

sudo mkdir -p ./tmp_mnt
sudo mount -o loop ramdisk ./tmp_mnt
sudo cp -avd $ROOTFS_DIR/* ./tmp_mnt/
# sudo cp -rf $ROOTFS_DIR/* ./tmp_mnt/
sudo umount ./tmp_mnt
sudo rm -rf ./tmp_mnt

sudo gzip --best ./ramdisk

sudo chown -R `whoami` ramdisk.gz
sudo chgrp -R `whoami` ramdisk.gz

mv ./ramdisk.gz $OUTPUT_DIR