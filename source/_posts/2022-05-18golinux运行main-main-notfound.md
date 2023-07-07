---
title: golinux运行main./main:notfound
categories:
  - 默认
date: 2022-05-18 12:52:21
tags:
  - Golang
---



  go linux运行main ./main: not found
    ./main: not found

<!--more-->


golang主要是用的gun-libc库，而有些发行版的linux默认没有，例如alpine linux，执行以下命令，软连接musl-libc，因为这两个库基本兼容，或者你可以自己安装gun-libc，但是alpinelinux 官方说这样就和其他发行版没区别了，主要是为了小巧，仅10Mb的操作系统
```shell
mkdir /lib64
ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
```



## alpine安装go gcc
```sh
apk add gcc g++ make cmake gfortran libffi-dev openssl-dev libtool
```