---
title: docker管理面板Portainer
tags: []
excerpt: >-
  HTTPSdocker run -d  --name portainer --restart=always -p 9443:9443 -v
  /var/run/docker.sock:/var/r...
date: 2023-02-27 22:32:57
---

HTTPSdocker run -d --name portainer --restart=always -p 9443:9443 -v /var/run/docker.sock:/var/r...
<!-- more -->
HTTPS

```
docker run -d  --name portainer --restart=always -p 9443:9443 -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`:/data    portainer/portainer-ce:latest  --ssl true --sslcert=/data/ssl.crt  --sslkey=/data/ssl.key
```

#qrcodeWrapper { margin:0 auto; text-align: center; } #qrcodeWrapper img { margin:0 auto; }

扫描二维码，在手机上阅读！