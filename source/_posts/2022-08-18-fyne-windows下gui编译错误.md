---
title: fyne windows下gui编译错误
categories:
  - 默认
date: 2022-08-18 13:27:06
tags:
  - Golang
---


好麻烦，有无快捷办法

https://blog.csdn.net/weixin_64064486/article/details/123940266


【更新】

https://developer.fyne.io/started/#prerequisites

1.下载,并安装
https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-x86_64-20220603.exe

2.从 开始菜单打开MSYS2

3.输入命令
```
pacman -Syu
```
选择 gcc
```
pacman -S git mingw-w64-x86_64-toolchain
```