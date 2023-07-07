---
title: 搭建code-server
categories:
  - 默认
date: 2023-05-23 13:54:33
tags:
  - CodeServer
  - Docker
---



搭建网页版的vscode

<!--more-->


```sh
rm -rf  /home/codeserver
```

```sh
ssh-keygen -t rsa -b 4096 -C "vscode"
```

## golang环境
```sh
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz

curl -O    https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz 

export PATH=$PATH:/usr/local/go/bin
source /etc/profile
```

```sh
docker kill code-server
docker rm code-server


docker run -d  \
--name=code-server   \
-e TZ=Etc/UTC \
-e PUID=0 \
-e PGID=0 \
-e  PASSWORD=272745 \
-e   SUDO_PASSWORD=272745 \
-e   DEFAULT_WORKSPACE=/home/codeserver/workspace  \
-e   HOME=/home/codeserver/  \
-p 8443:8443   \
-v /home/codeserver/workspace:/home/codeserver/workspace \
-v /home/codeserver/config:/config \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/bin/docker:/usr/bin/docker  \
--restart unless-stopped  \
 lscr.io/linuxserver/code-server:latest

```