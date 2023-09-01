---
title: KangleServer
categories:
  - 教程
date: 2022-08-14 13:15:48
tags:
  - kangle
---
  

## kangle CHM手册 下载

<!--more-->

[kangle中文帮助手册help_chm.rar][1]

[kangle中文帮助手册.pdf][2]




## Centos安装

手动安装 cmake

```sh
yum install -y wget 
wget https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5.tar.gz
tar -zxvf cmake-3.15.5.tar.gz
cd cmake-3.15.5
./bootstrap && make -j4 && make install
```

手动安装 zlib
```sh
wget http://www.zlib.net/zlib-1.2.12.tar.gz
tar -zxvf zlib-1.2.12.tar.gz
cd zlib-1.2.12
./configure && make  && make install
```

手动安装openssl
```sh
wget https://www.openssl.org/source/openssl-1.1.1b.tar.gz  --no-check-certificate

tar zxvf openssl-1.1.1b.tar.gz
cd openssl-1.1.1b
./config
make
make install
```


[1]:  ./940376169.rar
[2]: ./1544481089.pdf
