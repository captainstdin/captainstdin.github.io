---
title: redis集群搭建docker-compose
categories:
  - 默认
date: 2022-09-08 13:35:55
tags:
  - Docker
  - redis
---


## 使用 docker 构建reids集群节点


<!--more-->

默认配置文件，只需要修改 `requirepass`的密码和 `masterpassauth` 密码

授权 `requirepass` 默认 `woshitiancai`
端口 `port` 默认 `6379`
aof `dir` 默认 `/data`

### > 1.构建镜像
```sh
docker build -t qqfirst/redis_cluster .
```

### > 2.节点启动镜像


```sh
# 若要保存AOF，则外加 -v `pwd`/aof:/data
docker run -d --net=host  --name redis_cluster  qqfirst/redis_cluster
```


### > 3.编排节点启动，或者使用已存在的节点

```sh
docker run -it --name redis_cluster qqfirst/redis_cluster sh
```

### > 4.节点编排
```sh
redis-cli --cluster create  ip:port  ip:port ip:port    --cluster-relicas 1  -a 密码
```


### > 例如
```sh
redis-cli --cluster create   -a woshitiancai   host.docker.internal:6378 host.docker.internal:6377 host.docker.internal:6376 host.docker.internal:6375  host.docker.internal:6374  host.docker.internal:6373  --cluster-replicas 1
```



## 使用docker-compose 构建集群(测试)

### > 1.启动6个节点

```sh
docker-compose up
```

![1.png][1]

### > 2.选择一个节点启动cluster
```sh
redis-cli --cluster create   -a woshitiancai   10.0.0.2:6379 10.0.0.3:6379 10.0.0.4:6379 10.0.0.5:6379 10.0.0.6:6379 10.0.0.7:6379  --cluster-replicas 1
```
![2.png][2]

### > 附加1: 智能化客户端编排 hashkey
![3.png][3]

### > 附加2：集群信息

![4.png][4]

## 常见问题
### 1.为什么Waiting for the cluster to join 一直卡在这里

```
1: https://www.cnblogs.com/luck-pig/p/12311320.html 
2: 需要修改redis.conf  1378行

# cluster-announce-ip 10.1.1.5
# cluster-announce-port 6379
# cluster-announce-bus-port 6380

```


### 2.At least 6 nodes are required.

```
redis集群必须至少3个master ， --cluster-replicas 为1 的时候 一个master配1个s 副本，

所以最少要6个redis
```

### 3.WRONGPASS invalid username-password pair

```
使用 -a 密码来解决连接问题
```


[1]: ./typecho/uploads/2022/09/2887596996.png
[2]: ./typecho/uploads/2022/09/3020395733.png
[3]: ./typecho/uploads/2022/09/4233324285.png
[4]: ./typecho/uploads/2022/09/1787203346.png