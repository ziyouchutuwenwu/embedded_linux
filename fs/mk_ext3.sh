#!/bin/bash

if [ ! -n "$1" ] ;then
    echo "usage: $0 $HOME/downloads/rootfs/ 32768 ../"
    echo "please input rootfs dir"
    exit 1
fi

if [ ! -n "$2" ] ;then
    echo "usage: $0 $HOME/downloads/rootfs/ 32768 ../"
    echo "please input output file size, unit kbytes"
    exit 1
fi

if [ ! -n "$3" ] ;then
    echo "usage: $0 $HOME/downloads/rootfs/ 32768 ../"
    echo "please input output dir"
    exit 1
fi

ROOTFS_DIR=$1
FILE_SIZE=$2
OUTPUT_DIR=$3

sudo dd if=/dev/zero of=rootfs.ext3 bs=1k count=$FILE_SIZE
sudo mkfs.ext3 rootfs.ext3

sudo mkdir -p tmp_mnt
sudo mount -t ext3 rootfs.ext3 tmp_mnt/ -o loop

sudo cp -r $ROOTFS_DIR/* tmp_mnt/
sudo umount tmp_mnt

sudo chown -R `whoami` ./rootfs.ext3
sudo chgrp -R `whoami` ./rootfs.ext3

sudo rm -rf tmp_mnt
sudo mv ./rootfs.ext3 $OUTPUT_DIR