---
title: Alpine同步时间ntp
categories:
  - Linux
date: 2022-06-30 13:07:26
tags:
  - AlpineLinux
---


```shell
ntpd -d -q -n -p ntp3.aliyun.com
```

开机对时：
```shell
vim vim /etc/local.d/ntp.start

rc-update add local
```