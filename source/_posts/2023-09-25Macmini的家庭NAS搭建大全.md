---
title: MacMini的家庭NAS搭建大全
categories:
  - 默认
date: 2023-09-25 12:49:11
cover: ./2023/09/25/2023-09-25Macmini的家庭NAS搭建大全/macmini.png
tags: 
  - macmini
  - NAS
---


## 拼夕夕 2899 RMB

[//]: # (![MacMini M2]&#40;./macmini.png&#41;)

<!-- more -->
<!-- toc -->
## 我的MacMini的家庭NAS目录

```text
admin@macmini ~ % ls -la
total 136
drwxr-x---+ 38 admin  staff   1216 10  1 18:24 .
drwxr-xr-x   5 root   admin    160  9 30 20:57 ..
-r--------   1 admin  staff      9  9 23 09:01 .CFUserTextEncoding
-rw-r--r--@  1 admin  staff  14340  9 30 20:16 .DS_Store
drwx------+  2 admin  staff     64  9 30 21:13 .Trash
drwxr-xr-x@  2 admin  staff     64  9 23 15:00 .android
-rw-r--r--   1 admin  staff    148  9 23 15:01 .bash_profile
drwxr-xr-x@  5 admin  staff    160  9 28 09:30 .config
drwxr-xr-x@ 11 admin  staff    352  9 30 21:11 .docker
-rw-r--r--   1 admin  staff   1508  9 23 15:01 .jetbrains.vmoptions.sh
-rw-------   1 admin  staff     20  9 27 15:56 .lesshst
-rw-r--r--   1 admin  staff    148  9 23 15:01 .profile
drwx------   6 admin  staff    192  9 27 15:41 .ssh
-rw-------   1 admin  staff  11373  9 28 09:38 .viminfo
-rw-r--r--   1 admin  staff     86  9 28 09:30 .zprofile
-rw-------   1 admin  staff  11804  9 30 21:13 .zsh_history
drwx------  52 admin  staff   1664 10  1 18:24 .zsh_sessions
-rw-r--r--   1 admin  staff    148  9 23 15:01 .zshrc
drwx------+  4 admin  staff    128  9 30 20:20 Desktop
drwx------+  4 admin  staff    128  9 24 19:50 Documents
drwx------+ 17 admin  staff    544  9 26 09:23 Downloads
drwxrwxrwx@  5 nas    staff    160  9 28 09:21 IdeaProjects
drwx------@ 93 admin  staff   2976  9 30 21:11 Library
drwx------   3 admin  staff     96  9 23 08:37 Movies
drwx------+  4 admin  staff    128  9 23 09:15 Music
drwx------+  5 admin  staff    160  9 23 23:26 Pictures
drwxrwxrwx+  7 admin  staff    224  9 24 17:57 Public
drwxr-xr-x   6 admin  staff    192  9 30 19:58 alist
drwx------@  7 admin  staff    224  9 23 15:09 ddns-go_5.6.2_darwin_arm64
drwxr-xr-x   6 admin  staff    192  9 23 14:08 emby
drwxrwxrwx+  9 admin  staff    288  9 25 10:52 ha
drwx------   7 admin  staff    224  9 23 09:13 iCloud云盘（归档）
drwxr-xr-x   3 admin  staff     96  9 23 13:23 iperf
drwxr-xr-x@ 10 nas    staff    320  9 14 20:03 jetbra
drwxr-xr-x   7 admin  staff    224  9 23 12:42 openvpn
drwxr-xr-x@  5 admin  staff    160  9 23 12:44 openvpn-as
drwxr-xr-x@  6 nas    staff    192  9 22 19:43 src
drwxrwxrwx   8 admin  staff    256  9 23 13:26 trassmission
```

<div class="justified-gallery">

 ![1.pt下载器](./trassmission.png)  
 ![2.在线网盘](./alist.png) 
 ![3.ddns动态IPv6公网](./ddns.png) 
![4.内网测试speedtest](./speedtest.png)
 ![5.文件共享](./smb.png)      
  ![6.内网测速iperf](./iperf.png)  
 ![7.iCloud缓存加速器](./icloudproxy.png) 

</div>







## 1. 如何搭建PT下载终端,Transmission

搭建位置:  
`/User/admin/transmission`

在搭建位置新建一个文件  
`docker-compose.yaml`  

```yaml
version: "2.1"
services:
  transmission:
    image: linuxserver/transmission:latest
    container_name: transmission
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - USER = admin
      - PASS =  password
      - TRANSMISSION_WEB_HOME = /usr/share/transmission/public_html #
      #- WHITELIST= #optional
      #- PEERPORT= #optional
      #- HOST_WHITELIST= #optional
    volumes:
      - $PWD/src:/usr/share/transmission/public_html/
      - $PWD/config/:/config
      - $PWD/downloads/:/downloads
      - $PWD/transmission/watch/:/watch
    ports:
      - 9091:9091
      - 51413:51413
      - 51413:51413/udp
    restart: always
```
  
- 其他事项:  
  1. 搭建完后访问: http://hostname.local:9091
  2. 美化界面:请在本网站右上角搜索,transmission 探索高级功能
  3. `HOST_WHITELIST`好像是可以设置白名单域名,可以绕过密码,例如设置 `xx.local`
  4. 遇到与pt站通讯错误, 修改种子的`https`改为`http`


## 2. 如何搭建 个人网盘


```yaml
version: "2.1"
services:
  transmission:
    image: xhofe/alist:main
    container_name: alist
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    volumes:
      - $PWD/home/:/home
      - $PWD/etc/:/opt/alist/data
    ports:
      - 5244:5244
    restart: always
```

1. docker参数内容
  - `/home` 是为了后面alist添加本地储存的目录
  -  通过 `http://hostname.local:5244` 访问
2. 如何设置初始化密码






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

