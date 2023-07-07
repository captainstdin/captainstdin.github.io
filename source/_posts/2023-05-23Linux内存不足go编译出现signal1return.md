---
title: Linux内存不足go编译出现signal1return
categories:
  - Linux
date: 2023-05-23 13:53:49
tags:
  - AlpineLinux
---


```
dd if=/dev/zero of=/swapfile bs=1M count=2048
chmod 600 /swapfile
swapon /swapfile
/swapfile swap swap defaults 0 0
```