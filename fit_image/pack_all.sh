#!/bin/bash

./scripts/mk_kernel_uImage.sh ~/downloads/u-boot-2019.07/ 0x80008000 ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/zImage ./
./scripts/mk_ramdisk_uImage.sh ~/downloads/u-boot-2019.07/ 0x53000000 ~/downloads/buildroot-2019.05.1/output/images/ramdisk.gz ./

cp ./scripts/template.its ./build.its

sed -i 's#KERLEL_UIMAGE_TEMPLATE#kernel_uImage#g' ./build.its
sed -i 's#KERNEL_ADDR#0x80008000#g' ./build.its
sed -i 's#DTB_TEMPLATE#/home/mmc/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/dts/vexpress-v2p-ca9.dtb#g' ./build.its
sed -i 's#RAMDISK_UIMAGE_TEMPLATE#ramdisk_uImage#g' ./build.its
sed -i 's#RAMDISK_ADDR#0x53000000#g' ./build.its

./scripts/do_pack.sh ~/downloads/u-boot-2019.07/ ./build.its ./

rm -rf ./build.its
rm -rf ./kernel_uImage
rm -rf ./ramdisk_uImage