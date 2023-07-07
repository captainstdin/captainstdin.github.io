---
title: php拓展-php安装yacyaconf拓展；ClassYaconfnotfound
categories:
  - 默认
date: 2022-08-18 13:24:25
tags:
  - PHP
---


### download resource
```sh
git clone  https://github.com/laruence/yaconf
```



```sh
 cd yaconf/
 phpize
./configure --with-php-config=/www/server/php/73/bin/php-config
make -j
 make install
```

最后添加到php.ini

```ini

extension=/www/server/php/73/lib/php/extensions/no-debug-non-zts-20180731/yaconf.so
```
