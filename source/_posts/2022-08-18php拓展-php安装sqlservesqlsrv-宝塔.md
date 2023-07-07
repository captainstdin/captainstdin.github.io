---
title: php拓展-php安装sqlservesqlsrv-宝塔
categories:
  - 教程
date: 2022-08-18 13:21:44
tags:
  - PHP
---



laravel报错

```
Illuminate\Database\QueryException
could not find driver (SQL: select top 1 * from [lswl_event] where [lswl_event].[event_id] = 1)
```


一、【加入微软的源】
```sh
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssqlrelease.repo
```
二、【安装驱动】
```sh
yum -y install msodbcsql mssql-tools unixODBC-devel
```

3、编译

```sh
wget http://pecl.php.net/get/pdo_sqlsrv-5.8.0.tgz
tar -zxvf  pdo_sqlsrv-5.8.0.tgz
cd pdo_sqlsrv-5.8.0

phpize
./configure  --with-php-config=/www/server/php/73/bin/php-config
make
make install 

```

4、 修改php.ini

```ini
extension=/www/server/php/73/lib/php/extensions/no-debug-non-zts-20180731/pdo_sqlsrv.so
```

