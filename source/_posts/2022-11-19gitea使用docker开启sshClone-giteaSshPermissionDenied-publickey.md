---
title: gitea使用docker开启sshClone giteaSshPermissionDenied-publickey.
categories:
  - 默认
date: 2022-11-19 13:44:58
tags:
  - Docker
  - gitea
---
  

# 经常看到gitea 关于ssh配置的问题

Permission denied (publickey).

## 下面开始手把手的教程

<!--more-->


## 0. 原理

原理

```

client(你  ssh cLone )  -> 

Linux:22 (宿主机:22)  使用git账号（宿主机/home/git/.ssh/authorized_keys） ->

配置搭建转发 /usr/local/bin/gitea ->

ssh (宿主机) 连接 127.0.0.1:2222(docker容器的22端口映射) -> 
        
携带类似nginx转发的数据到 容器:2222 进行git 操作

```

## 1.  搭建服务器 ssh隧道转发

### 1.1 添加`git`用户作为ssh专用的用户

```sh
mkdir /home/git
useradd git

```

### 1.2  生成`git`用户的rsa ssh登录密钥对

一定要加`sudo -u` 不然是生成root用户的密钥对。
或者你su  git 切换用户生成先，记得切回ROOT  `chown git:git /home/git`

```sh

## 一路按回车就好了，千万不要输入 parsePasswd ，不然你每次git clone都要输入这个密码
sudo -u git ssh-keygen -t rsa -b 4096 -C "Gitea Host Key"

chown git:git /home/git
```

### 1.3 修改`.ssh`  特殊权限，错误设置无法ssh登录!
```sh
chmod 755 /home/git
chmod 700  /home/git/.ssh
chmod 600  /home/git/.ssh/authorized_keys
```

### 1.4 `宿主机`开启 RSA证书登录
```sh
vim /etc/ssh/sshd_conf
#将PubkeyAuthentication yes前边的#去掉。这样证书登录就开启了。

#重启SSH服务
systemctl restart sshd
```


## 2.  搭建服务器 docker启动

### 2.1 查看`git`用户的 GUID和UID ，我这里是 `1001` 每个人不一样

```sh
ids git
## uid=1001(git) gid=1001(git) groups=1001(git)
```

### 2.1 编写`gitea.sh` 使用git用户启动,修改下面的`-e USER_UID=`和`-e USER_GID=` 为上面的数值

`vim gitea.sh`

内容为
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

### 2.2 配置 22:->2222 ssh转发带来
```vi /usr/local/bin/gitea```

保存以下的脚本
```sh
ssh -p 2222 -o StrictHostKeyChecking=no git@127.0.0.1 "SSH_ORIGINAL_COMMAND=\"$SSH_ORIGINAL_COMMAND\" $0 $@"
```

```
chmod -R 777 /usr/local/bin/gitea
```

## 3. 你的电脑 配置

### 3.1 生成密钥对

打开git CMD

```sh 
## 一路按回车就好了，千万不要输入 parsePasswd ，不然你每次git clone都要输入这个密码
ssh-keygen -t rsa -b 4096 -C "Gitea Host Key"
```

把id_rsa.pub 内容 复制到 你的`gitea网站`上  `xxx.com/user/settings/keys`

windows `C:\Users\admin\.ssh\id_rsa.pub`

linux `~/.ssh/id_rsa.pub`



