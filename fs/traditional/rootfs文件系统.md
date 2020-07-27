# rootfs 文件系统

## busybox 下载

```bash
https://busybox.net/downloads/
```

## 编译

### menuconfig

```bash
settings
Build options
勾选 Build BusyBox as a static binary (no shared libs)
() Cross Compiler prefix，建议设置为 arm-linux-gnueabi-
```

### make

```bash
make install
```

默认编译结果在 busybox 的\_install 子目录

## 准备 sd 卡文件目录

- 先在物理主机环境下，形成目录结构，里面存放的文件和目录与单板上运行所需要的目录结构完全一样，然后再打包成镜像（在开发板看来就是 SD 卡），这个临时的目录结构称为根目录。详细参见 mkrootfs.sh

- 需要的 etc 配置文件从这里下载

```bash
http://files.cnblogs.com/files/pengdonglin137/etc.tar.gz
```

etc/init.d/rcS 里面可以自定义一些命令配置，比如，ip 地址，这个很有用

## qemu 模拟

```bash
qemu-system-arm \
 -M vexpress-a9 \
 -m 512M \
 -kernel ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/zImage \
 -dtb ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
 -nographic \
 -append "root=/dev/mmcblk0 console=ttyAMA0" \
 -sd /home/mmc/downloads/rootfs.ext3
```

## 目录不可写的话，这个命令解决

```bash
mount -o remount rw /
```
