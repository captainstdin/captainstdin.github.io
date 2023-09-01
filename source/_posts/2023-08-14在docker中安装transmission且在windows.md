---
title:  在docker中安装transmission且在windows
categories:
  - 默认
date: 2023-08-14 10:43:53
tags:
  - docker
---

## docker-compose.yaml 文件

<!--more-->



```docker-compose
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
      - E:\docker\transmission\src:/usr/share/transmission/public_html/
      - /E:\docker\transmission\config/:/config
      - E:\docker\transmission\downloads/:/downloads
      - E:\docker\transmission\watch/:/watch
    ports:
      - 9091:9091
      - 51413:51413
      - 51413:51413/udp
    restart: always
```



## 下载美化包

[美化包](./src.zip)