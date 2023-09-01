---
title: 易支付docker-compose部署
categories:
  - 教程
date: 2022-05-12 11:58:58
tags: 
  - Dockerfile
---

易支付docker-compose部署

<!-- more -->

```yaml
version: "3.0"
services:
  paywebfpm:
    build: ./web
    ports:
      - 80:80
    volumes:
      - ./web:/app/   #宿主机：容器
    dns: 
      - 223.5.5.5
      - 223.6.6.6
    networks:
      pay-network:
        aliases:
          - paywebfpm
        
  mariadb:
    image: qqfirst/mariadb:latest
    ports:
      - 3306:3306
    depends_on:
      - paywebfpm
    environment:
      - "ROOT_PASSWORD:123456"
    volumes:
      - ./mysql:/var/lib/mysql
    dns: 
      - 223.5.5.5
      - 223.6.6.6
    networks:
      pay-network:
        aliases:
          - mariadb

networks:
  pay-network:
    # driver:  custom-driver-1
```