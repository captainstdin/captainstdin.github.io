---
title: gitea从windows搬迁到linuxdocker
categories:
  - 教程
date: 2022-11-15 13:43:34
tags:
  - Docker
  - gitea
---


之前在windows上图方便使用 gitea，现在要搬迁到 linux下的docker部署中

<!--more-->


# 模块1.0 搭建Gitea

## 1:把windows的目录下3个文件夹搬迁

`custom`和`data` 和`log` 搬迁到 linux下 `/home/gitea/`

## 2:修改 `custom/conf/app.ini` 的路径和其他参数


## 3. 申请 ssl证书，改为 `ssl.crt` (原来可能是`xxxx.pem`) 和 `ssl.key` 放入 `/home/gitea/ssl/`

```

RUN_USER = git

[database]
PATH     =/data/gitea/gitea.db
[repository]
ROOT = /data/gitea/gitea-repositories

[server]
SSH_DOMAIN       = 42.192服务器IP
DOMAIN           = 42.192服务器IP

PROTOCOL        = https
CERT_FILE       = /data/gitea/ssl/ssl.crt
KEY_FILE        =/data/gitea/ssl/ssl.key
HTTP_PORT        = 3000

ROOT_URL         =https://改为你的最终的域名和端口(前端用的,端口不是3000，而是docker决定的)

[lfs]
PATH = /data/gitea/lfs

[log]
ROOT_PATH = /data/gitea/log

```


## 3. docker 启动

```sh
docker kill gitea
docker rm gitea

mkdir -p /home/git/.ssh
docker run -it \
--name=gitea \
-p80:3000 \
-p127.0.0.1:2222:22 \
-e USER_UID=1001 \
-e USER_GID=1000 \
-v `pwd`/public:/data/gitea/public \
-v `pwd`/templates:/data/gitea/templates \
-v `pwd`/data:/data/gitea \
-v `pwd`/log:/data/gitea/log \
-v `pwd`/custom/conf/app.ini:/data/gitea/conf/app.ini \
-v /home/git/.ssh/:/data/git/.ssh \
gitea/gitea:latest

```

## 其他问题
### 0. 不使用账号密码，如何开启SSH clone


请在本博客搜：

###  1. 我原来上传的 用户头像和组织头像不能显示了，

因为官方 docker镜像 的gitea的默认配置和windows下的默认不同，需要具体指定，修改 `custom/conf/app.ini`

```
[picture]
DISABLE_GRAVATAR        = true
ENABLE_FEDERATED_AVATAR = false
AVATAR_STORAGE_TYPE = local
AVATAR_UPLOAD_PATH      = /data/gitea/avatars
REPOSITORY_AVATAR_STORAGE_TYPE = local
```


然后  重启docker
```sh
docker restart gitea
```


## 额外-模板

自定义模板:
1. 在container软件包界面，增加FROM用法
2. 修改home界面
3. 登陆后顶部多了`软件包`,`仓库` 导航栏

[templates.zip][1]


[1]: /usr/uploads/2022/12/977849980.zip