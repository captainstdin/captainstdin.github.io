---
title: php-pcntl+socket
categories:
  - 默认
date: 2022-08-19 13:29:15
tags:
  - PHP
---
php-pcntl+socket②


<!--more-->


```php
<?php

class SocketServer
{

    public $socket;

    public $all_sockets = [];

    public function __construct(string $address)
    {
        //创建监听socket服务 资源句柄 ,,resource|false
        $this->socket = \stream_socket_server($address, $php_errorcode, $php_errormsg);

        if ($this->socket == false) {
            throw new \Exception('创建失败！', $php_errorcode, $php_errormsg);
        }

        \stream_set_blocking($this->socket, false);

        //当前初始化的第一个socket服务 资源句柄放入 资源池
        $this->all_sockets[intval($this->socket)] = $this->socket;
        echo ('=== 服务器启动|' . $address.PHP_EOL);
    }

    public function run()
    {
        //死循环
        while (true) {
            $write=$except=null;
            $allSocket=$this->all_sockets;
            \stream_select($allSocket, $write, $except, 60);

            foreach ($allSocket as $index => $socket) {
                //如果 streamsocket 服务句柄 == 当前socket资源池的id，说明有新连接
                if ($this->socket === $socket) {
                    // 接受由 stream_socket_server() 创建的套接字连接 timeout/覆盖默认的套接字接受的超时时限。输入的时间需以秒为单位
                    // resource|false
                    $new_conn_socket = \stream_socket_accept($this->socket);
                    if ($new_conn_socket == false) {
                        //可能是建立连接异常
                        continue;
                    }
                    $this->onConn($new_conn_socket);
                    $this->all_sockets[intval($new_conn_socket)] = $new_conn_socket;
                    echo '=== 新连接建立'.(int)($new_conn_socket).PHP_EOL;
                } else {
                    //如果不是新的连接,则看看有无数据过来,读取长度 65536
                    $buff = fread($socket, 0xFFFF);
                    // 不能是 == ''
                    if ($buff === '' || $buff === false) {
                        //客户端已断开
                        echo '=== 断开连接'.intval($socket).PHP_EOL;
                        $this->onClose($socket);
                        unset($this->all_sockets[intval($socket)]);
                        fclose($socket);
                        continue;
                    }
                    //处理发来的数据
                    $this->onMessage($socket, $buff);
                }
            }
        }
    }


    public function onConn(mixed $socket)
    {

    }

    public function onClose(mixed $socket)
    {
    }

    public function onMessage(mixed $socket, $buff)
    {
        $body = 'hello word';
        $header = [
            'HTTP/1.1 200 OK',
            'Connection: keep-alive',
            'Niubi: test123',
            'Content-length:' . strlen($body)
        ];
        $header_string = \implode(chr(0x0D) . chr(0x0A), $header);

        $data = $header_string . chr(0x0D) . chr(0x0A) . chr(0x0D) . chr(0x0A) . $body;


//        echo '用户数据：'.$buff.PHP_EOL;
        fwrite($socket, $data);

        unset($this->all_sockets[intval($socket)]);
        fclose($socket);
    }

}


$a = new SocketServer('tcp://0.0.0.0:88');
$a->run();;

```

![php-pcntl+socket.png][1]


[1]: ./typecho/uploads/2022/08/3051346119.png