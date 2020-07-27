# gdb 内核调试

## 需要

```bash
sudo apt install gdb-multiarch
```

make config 以后，.config 文件里面检查有没有这个

```python
CONFIG_DEBUG_INFO=y
```

## 编译，运行

```bash
qemu-system-arm \
 -M vexpress-a9 \
 -m 512M \
 -kernel ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/zImage \
 -dtb ~/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
 -nographic \
 -append "console=ttyAMA0" \
 -s -S \
 -serial mon:stdio
```

```bash
gdb-multiarch /home/mmc/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/compressed/vmlinux
(gdb) target remote localhost:1234
(gdb) b start_kernel
(gdb) c
```

## gdb 前端界面推荐 vscode + native debug 插件
