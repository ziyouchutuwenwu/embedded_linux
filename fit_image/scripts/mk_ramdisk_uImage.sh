#!/bin/bash

if [ ! -n "$1" ] ;then
    echo "usage: $0 UBOOT_DIR MEM_ADDR RAMDISK_WITH_PATH OUTPUT_DIR"
    echo "please input UBOOT_DIR"
    exit 1
fi

if [ ! -n "$2" ] ;then
    echo "usage: $0 UBOOT_DIR MEM_ADDR RAMDISK_WITH_PATH OUTPUT_DIR"
    echo "please input MEM_ADDR"
    exit 1
fi

if [ ! -n "$3" ] ;then
    echo "usage: $0 UBOOT_DIR MEM_ADDR RAMDISK_WITH_PATH OUTPUT_DIR"
    echo "please input ZIMAGE_WITH_PATH"
    exit 1
fi

if [ ! -n "$4" ] ;then
    echo "usage: $0 UBOOT_DIR MEM_ADDR RAMDISK_WITH_PATH OUTPUT_DIR"
    echo "please input OUTPUT_DIR"
    exit 1
fi

UBOOT_DIR=$1
MEM_ADDR=$2
RAMDISK_WITH_PATH=$3
OUTPUT_DIR=$4

$UBOOT_DIR/tools/mkimage -A arm -O linux -C none -T kernel -a $MEM_ADDR -e $MEM_ADDR -n ramdisk_uImage -d $RAMDISK_WITH_PATH $OUTPUT_DIR/ramdisk_uImage