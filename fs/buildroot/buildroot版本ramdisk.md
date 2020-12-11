# buildroot 版本 ramdisk

## 先编译内核

### make 默认 config

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 clean
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 vexpress_defconfig

```

### menuconfig

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 menuconfig
```

```sh
配置，注意，勾选的必须要为*，不能是 M，这里调了若干小时。。。。。。。。。。。
General Setup
勾选 Initial RAM filesystem and Ram disk(initramfs/initrd) support
Device Drivers
勾选 Block devices
勾选 RAM block device support
Default number of RAM disks
Default RAM disk size(kbytes)
这里，举个例子，16M，应该写 16384, 16*1024，备忘
在 Generic Driver options
勾选 Automount devtmpfs at /dev, after the kernel mounted the rootfs
File system
勾选 Ext2 extended attributes 和其下所有子项
```

### code ./out_vexpress_4_19/.config

- 修改 CONFIG_CMDLINE 为

```sh
CONFIG_CMDLINE="root=/dev/ram0 rw init=/linuxrc console=ttyAMA0"
```

- make

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 -j8
```

## qemu 模拟

```sh
qemu-system-arm \
 -M vexpress-a9 \
 -m 512M \
 -kernel ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/zImage \
 -dtb ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
 -nographic \
 -append "root=/dev/ram0 rw init=/linuxrc console=ttyAMA0" \
 -initrd ~/downloads/buildroot-2019.05.1/output/images/ramdisk.gz
```
