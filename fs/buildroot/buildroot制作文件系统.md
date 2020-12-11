# buildroot 制作文件系统

## 下载 buildroot

```sh
https://buildroot.org/downloads/buildroot-2019.05.1.tar.gz
```

## make menuconfig

- 在 toolchain 下面设置编译器，内核支持版本，这个版本不能比编译的内核的版本高，低没测试，我选的一样的

- 内核需要修改编译选项

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 menuconfig

勾选下面这个，否则会出现 can't open /dev/null: No such file or directory
Device Drivers
Generic Driver options
Automount devtmpfs at /dev, after the kernel mounted the rootfs
```

## 重新编译内核

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 -j8
```

最后生成的文件系统在
\$BUILD_ROOT_DIR/output/images/rootfs.tar

## qemu 启动

```sh
qemu-system-arm \
 -M vexpress-a9 \
 -m 512M \
 -kernel ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/zImage \
 -dtb ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
 -nographic \
 -append "root=/dev/mmcblk0 console=ttyAMA0" \
 -sd /home/mmc/downloads/buildroot-2019.05.1/output/images/rootfs.ext2
```
