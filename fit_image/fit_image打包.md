# fit_image 打包

[参考地址](http://www.bankaiyuan.com/t/246)

## 先 make 一下默认配置

```sh
cd \$UBOOT
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- vexpress_ca9x4_defconfig
```

## code .config，添加 fit 模式的支持

- 注意，修改下面为

```python
CONFIG_FIT=y
```

## make

```sh
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
```

## pack_all.sh 是打包的例子

```sh
现在内存地址仅作参考
内核在 0x80008000
ramdisk 在 0x53000000
```

## 暂时没有设备测试，等以后拿到设备以后，逐步调试
