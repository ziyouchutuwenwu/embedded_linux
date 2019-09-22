#!/bin/bash

if [ ! -n "$1" ] ;then
    echo "usage: $0 UBOOT_DIR ITS_CONFIG_FILE OUTPUT_DIR"
    echo "please input UBOOT_DIR"
    exit 1
fi

if [ ! -n "$2" ] ;then
    echo "usage: $0 UBOOT_DIR ITS_CONFIG_FILE OUTPUT_DIR"
    echo "please input ITS_CONFIG_FILE"
    exit 1
fi

if [ ! -n "$3" ] ;then
    echo "usage: $0 UBOOT_DIR ITS_CONFIG_FILE OUTPUT_DIR"
    echo "please input OUTPUT_DIR"
    exit 1
fi

UBOOT_DIR=$1
ITS_CONFIG_FILE=$2
OUTPUT_DIR=$3

$UBOOT_DIR/tools/mkimage -f $ITS_CONFIG_FILE $OUTPUT_DIR/kernel_with_dtb_ramdisk.itb