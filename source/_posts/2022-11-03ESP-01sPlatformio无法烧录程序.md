---
title: ESP-01sPlatformio无法烧录程序
categories:
  - 物联网
date: 2022-11-03 13:41:12
tags:
  - esp8266
---


## 修改 `platformio.ini`




```ini

[env:esp01_1m]
platform = espressif8266
board = esp01_1m
framework = arduino
upload_resetmethod = nodemcu #追加这行
```