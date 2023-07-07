---
title: docker管理面板Portainer
categories:
  - 默认
date: 2023-02-27 13:52:34
tags:
  - Dockerfile
---


HTTPS

```sh
docker run -d  --name portainer --restart=always -p 9443:9443 -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`:/data    portainer/portainer-ce:latest  --ssl true --sslcert=/data/ssl.crt  --sslkey=/data/ssl.key
```