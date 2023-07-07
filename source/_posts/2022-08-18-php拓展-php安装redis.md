---
title:  php拓展 php安装redis
categories:
  - 默认
date: 2022-08-18 13:26:06
tags:
  - PHP
---
  

```sh
git clone https://github.com/phpredis/phpredis
```

```sh
cd phpredis
phpize 
./configure --with-php-config=/www/server/php/73/bin/php-config
make && make install
ls  /www/server/php/73/lib/php/extensions/no-debug-non-zts-20180731/
```

追加`php.ini`
```ini
[redis]
extension = /www/server/php/73/lib/php/extensions/no-debug-non-zts-20180731/redis.so
```