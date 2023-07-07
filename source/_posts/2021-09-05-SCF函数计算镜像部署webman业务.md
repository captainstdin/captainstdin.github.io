---
title: SCF函数计算镜像部署webman业务
categories:
  - 教程
date: 2021-09-05 21:43:27
tags:
  - FC
  - Serverless
---


# 例子：在webman框架中编写一个发送邮件业务的接口，并且部署到云函数上

## 腾讯云SCF特点，全局只读，只有/tmp可写


+ 1: 编写代码，修改代码
+ 2: 本地测试运行
+ 3: 编写dockerfile， 推送到腾讯云镜像仓库
+ 4: 构建docker镜像，并且推送到腾讯云镜像仓库

+ 5: 部署到SCF
+ 6: 测试


<!--more-->

## 1: 编写代码，修改代码

### 1.1 下载webman https://www.workerman.net/doc/webman#/install


### 1.2 修改 start.php cli启动文件(因为上面说了 全局只读，workerman有一个log日志文件默认写入)

![](https://file.hu60.cn/file/hash/png/7e96286ae0320c6a6dc714299c2e7c7a380607.png)

```php
if(!file_exists(runtime_path().'/logfile')){
    file_put_contents(runtime_path().'/logfile',' ');
}
Worker::$logFile=runtime_path().'/logfile';
```


### 1.3 删除 /config/route.php 默认路由(不删除 不存在的路由会报错，无法启动框架)
![](https://file.hu60.cn/file/hash/png/854cf266f77b5c43d0e31315cc281321295706.png)

### 1.4 修改 /config/server.php 默认的http监听端口，通过server_listen环境变量传入
![](https://file.hu60.cn/file/hash/png/cd5af48582e9d042e5c3700d82097bf0264789.png)


### 1.5 composer安装 PHPMailer/PHPMailer拓展,并且开始写业务代码

### env() 函数来获取 环境变量，包括SCF传入的环境变量

![](https://file.hu60.cn/file/hash/png/517c49e69b9536be878464e17fb8b886578224.png)


```php
<?php
namespace app\v1\controller;
use PHPMailer\PHPMailer\PHPMailer;
use support\Request;

/**
 * Class Email
 * @package app\v1\Controller
 */
class Email
{
    public function send(Request $request)
    {
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->SMTPDebug = 0;
        $mail->CharSet = 'UTF-8';
        $mail->Host = env('V1_Email_Host');                // SMTP服务器
        $mail->SMTPAuth = true;                      // 允许 SMTP 认证
        $mail->Username = env('V1_Email_Username');                // SMTP 用户名  即邮箱的用户名
        $mail->Password = env('V1_Email_Password');             // SMTP 密码  部分邮箱是授权码(例如163邮箱)

        $mail->SMTPSecure = 'ssl';                    // 允许 TLS 或者ssl协议
        $mail->Port = 465;                            // 服务器端口 25 或者465 具体要看邮箱服务器支持
        $mail->isHTML(true);
        $mail->Subject = 'SCF函数发送邮件';
        $mail->Body = '<h1>这里是邮件内容</h1>' . date('Y-m-d H:i:s');

        $mail->setFrom($mail->Username);  //发件人
        $mail->addAddress($request->get('target'));  // 收件人
        $mail->send();

        return json([
            'code' => 0,
            'msg' => '发送成功'
        ]);
    }
}
```


## 2: 本地测试

```
php start.php start 本地启动框架
```

![](https://file.hu60.cn/file/hash/png/c0b7c510b2947eceb3f71ce626043c8f376942.png)

HTTP测试成功


![](https://file.hu60.cn/file/hash/png/1601d7a996f2ddbaf7cd6cfd496c9254132709.png)

## 3:编写dockerfile

![](https://file.hu60.cn/file/hash/png/f49cbf2e39fae38e9af41a66c5a46420276598.png)



```dockerfile
FROM qqfirst/webman

#下面操作都在容器 /app目录下
WORKDIR /app
#复制当前目录文件到 容器/app下
COPY / /app/
# 执行shell composer install
RUN composer install
# 创建 容器 /tmp 可写目录
RUN mkdir -p /tmp
# 删除 /app/runtime 自带运行目录
RUN rm -rf /app/runtime
# 软链接 宿主机的/tmp 可写目录 到 容器/app/runtime目录
RUN ln -s /tmp /app/runtime

# 设置环境变量 默认 config/server.php 配置
ENV server_listen=http://0.0.0.0:9000
ENV SERVER_PROCESS_COUNT=2
#暴露 90000
EXPOSE 9000

CMD ["php","/app/start.php","start"]
```

## 4: 开始docker构建

### 4.1 在这之前，我们去腾讯云 镜像仓库开通一个仓库 scf_webman_mail
![](https://file.hu60.cn/file/hash/png/04b00c895bb282c5deb4c8fae1ec98fb407418.png)


根据仓库提示，我们的完整 命名空间是 `ccr.ccs.tencentyun.com/pepper/scf_webman_mail`
![](https://file.hu60.cn/file/hash/png/8556a0a4f4192165c32a8e146c7cd9151187838.png)


### 4.2 开始docker 构建
```dockerfile
docker build -t ccr.ccs.tencentyun.com/pepper/scf_webman_mail  .
```

![](https://file.hu60.cn/file/hash/png/a8702a57ec0899bd575de384b8276d2d253302.png)


### 4.3 构建完毕后 推送腾讯仓库。（新机器需要 docker login 登陆，请自己了解腾讯云镜像仓库）

```dockerfile
docker push ccr.ccs.tencentyun.com/pepper/scf_webman_mail
```

![](https://file.hu60.cn/file/hash/png/fe9445095adea3767d8c960a9297a4c3439642.png)

## 5: 部署到SCF

![](https://file.hu60.cn/file/hash/png/0b1418bca58037d83867b7f0ca5398d1219026.png)

![](https://file.hu60.cn/file/hash/png/02aff0a3e56d7efd16d40d68357ae2d0303243.png)


### 检查下，大概就是这样
![](https://file.hu60.cn/file/hash/png/a7e727fb0a2c7c2bb085aaab38d16d24395520.png)


## 6: HTTP测试

![](https://file.hu60.cn/file/hash/png/294d359e38e191db921d645bb9ea8fd255182.png)

### 你看我就说 64Mb内存足够了，运行时间1ms，多亏了workerman框架 拯救了php-fpm的"慢"

![](https://file.hu60.cn/file/hash/png/7d786ee1d2b7c852f5fd04fa86d54c94339802.png)

![](https://file.hu60.cn/file/hash/png/c8394a89ab13075ece188efc197ba2e5578930.png)

