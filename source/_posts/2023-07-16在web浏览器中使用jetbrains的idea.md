---
title:  在web浏览器中使用jetbrains的idea
categories:
  - 默认
date: 2023-07-16 18:00:46
tags:
---


## 使用Docker拉取镜像

### 从projectorimages
```sh 
docker run -it --name golangd -p8887:8887  projectorimages/projector-goland
```

### 从sapce拉出
```sh 
docker run -it --name golangd -p8887:8887  registry.jetbrains.team/p/prj/containers/projector-goland
```