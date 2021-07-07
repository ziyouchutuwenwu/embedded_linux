# gdb 内核调试

## 安装需要的工具

```sh
sudo apt install gdb-multiarch
```

make config 以后，.config 文件里面检查有没有这个

```python
CONFIG_DEBUG_INFO=y
```

menuconfig 配置如下

```sh
Kernel hacking ->
  Compile-time checks and compiler options ->
    [*] compile the kernel with debug info
  [*] KGDB: kernel debugger
      <*> KGDB: use kgdb over the serial console
      [*] KGDB_KDB: include kdb frontend for kgdb
        (0x1) KDB: Select kdb command functions to be enabled by default
        (0) KDB: continue after catastrophic errors

System Type，取消 Enable the L2x0 outer cache controller
否则 qemu 起不来
```

## 编译，运行

```sh
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

```sh
gdb-multiarch /home/mmc/downloads/linux-4.19/out_vexpress_4_19/arch/arm/boot/compressed/vmlinux
(gdb) target remote localhost:1234
(gdb) b start_kernel
(gdb) c
```

## gdb 前端界面推荐 vscode + native debug 插件
