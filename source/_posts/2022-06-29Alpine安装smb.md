---
title: Alpine安装smb
categories:
  - Linux
date: 2022-06-29 18:07
tags:
  - AlpineLinux
---




SMB是Server Message Block的缩写，也被称为SMB协议或CIFS（Common Internet File System）。

<!--more-->


```sh
apk add samba
```

添加授权用户smb1
```sh
adduser  smb1
```

设置smb用户密码
```sh
smbpasswd -a smb1
```

```shell
vim /etc/samba/smb.conf
```

```ini
[global]
#to allow symlinks from everywhere
allow insecure wide links = yes 
workgroup = WORKGROUP
dos charset = cp866
unix charset = utf-8
force user = smb1

[xxx]
# to follow symlinks
follow symlinks = yes  
# to allow symlinks from outside
wide links = yes       
browseable = yes
writeable = yes
path = /root/

##config down
```

开机自启
```sh
rc-update add samba
```

启动
```sh
 rc-service samba start
```
