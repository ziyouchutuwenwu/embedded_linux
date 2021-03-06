# 配置 ramdisk

[参考链接](https://blog.csdn.net/yuntongsf/article/details/78207464)

## 配置内核

- menuconfig

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 clean
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 vexpress_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 menuconfig
```

- 配置

```sh
General Setup
  勾选 Initial RAM filesystem and Ram disk(initramfs/initrd) support
Device Drivers
  勾选 Block devices
    勾选 RAM block device support
    Default number of RAM disks
   Default RAM disk size(kbytes)
```

- code ./out_vexpress_4_19/.config
  修改 CONFIG_CMDLINE 为

```sh
CONFIG_CMDLINE="root=/dev/ram0 rw init=/linuxrc console=ttyAMA0"
```

## 编译内核

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=./out_vexpress_4_19 -j8
```

- 测试发现，这段 cmd_line 可以在内核构建的时候编译生成

```sh
如果是 qemu-system-arm，也可以不构建，在 append 里面直接传
如果是物理设备，可以修改 uboot 参数
```

- 修改 uboot 参数

```sh
set bootargs 'root=/dev/ram0 rw init=/linuxrc console=ttyAMA0'
```

## qemu 启动

```sh
qemu-system-arm \
 -M vexpress-a9 \
 -m 512M \
 -kernel ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/zImage \
 -dtb ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
 -nographic \
 -append "root=/dev/ram0 rw init=/linuxrc console=ttyAMA0" \
 -initrd ~/downloads/ramdisk.gz

```
