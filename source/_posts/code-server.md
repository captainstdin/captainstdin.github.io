---
title: code-server
tags: []
excerpt: >-
  rm -rf  /home/codeserverssh-keygen -t rsa -b 4096 -C "vscode"golang环境wget
  https://go.de...
date: 2023-05-23 21:48:00
---

rm -rf /home/codeserverssh-keygen -t rsa -b 4096 -C "vscode"golang环境wget https://go.de...
<!-- more -->
```
rm -rf  /home/codeserver
```

```
ssh-keygen -t rsa -b 4096 -C "vscode"
```

## golang环境

```
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz

curl -O    https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz 

export PATH=$PATH:/usr/local/go/bin
source /etc/profile
```

```
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

#qrcodeWrapper { margin:0 auto; text-align: center; } #qrcodeWrapper img { margin:0 auto; }

扫描二维码，在手机上阅读！