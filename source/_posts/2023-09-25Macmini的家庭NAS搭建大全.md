---
title: MacMini的家庭NAS搭建大全
categories:
  - 默认
date: 2023-09-25 12:49:11
tags: 
  - ios
  - NAS
---

# MacMini的家庭NAS搭建大全

<!-- more -->

## 刚买的MacMini M2



## 0x01 如何搭建PT下载终端

## 0x10 如何广播自己的局域网域名`pc.local` mDns

```sh 
 apk add avahi
 vi /etc/avahi/avahi-daemon.conf
```

在配置文件中找到以下行：

```
#host-name=foo
```
将其取消注释并将其值更改为您想要广播的主机名 
启动   服务：
``` 
rc-service avahi-daemon start
```

