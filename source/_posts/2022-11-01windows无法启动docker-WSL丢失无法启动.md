---
title: windows无法启动docker WSL丢失无法启动
categories:
  - 默认
date: 2022-11-01 13:40:33
tags:
  - Docker
---


## windows使用 `管理员` 权限 打开CMD

执行命令

```sh
netsh winsock reset
```

## 重启 done