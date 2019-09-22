#!/bin/bash

if [ ! -n "$1" ] ;then
    echo "usage: $0 $HOME/downloads/busybox-1.30.1/ ../"
    echo "please input busybox src dir"
    exit 1
fi

if [ ! -n "$2" ] ;then
    echo "usage: $0 $HOME/downloads/busybox-1.30.1/ ../"
    echo "please input output dir or rootfs"
    exit 1
fi

tar zxf ./etc.tar.gz

sudo rm -rf rootfs

BUSYBOX_DIR=$1
OUTPUT_DIR=$2

sudo mkdir rootfs
sudo cp $BUSYBOX_DIR/_install/*  rootfs/ -raf

sudo mkdir -p rootfs/proc/
sudo mkdir -p rootfs/sys/
sudo mkdir -p rootfs/tmp/
sudo mkdir -p rootfs/root/
sudo mkdir -p rootfs/var/
sudo mkdir -p rootfs/mnt/

sudo mv -f etc rootfs/

sudo cp -arf /usr/arm-linux-gnueabi/lib rootfs/

sudo rm rootfs/lib/*.a
sudo arm-linux-gnueabi-strip rootfs/lib/*

sudo mkdir -p rootfs/dev/
sudo mknod rootfs/dev/tty1 c 4 1
sudo mknod rootfs/dev/tty2 c 4 2
sudo mknod rootfs/dev/tty3 c 4 3
sudo mknod rootfs/dev/tty4 c 4 4
sudo mknod rootfs/dev/console c 5 1
sudo mknod rootfs/dev/null c 1 3

sudo chown -R `whoami` rootfs
sudo chgrp -R `whoami` rootfs

mv -f ./rootfs $OUTPUT_DIR