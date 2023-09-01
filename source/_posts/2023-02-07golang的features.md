---
title: golang的features
categories:
  - 默认
date: 2023-02-07 13:51:40
tags:
  - Golang
---


## make 特性

1. 返回的时候一个指针地址，且内容为nil
2. 只有 chan和map才需要用到
3. 可以预先设置容量


<!--more-->

## chan设计模式

会造成deadlock的情况
1:在阻塞channel中阻塞写入前无监听读取
```
ch1 := make(chan bool)
defer close(ch1)
ch1 <- true   //all goroutines are asleep - deadlock! 
```
2: 不会造成死锁

```
	go func() {
		time2.Sleep(time2.Second * 10)
		for true {
			<-ch1
		}
	}()
	ch1 <- true
```

## slice切片

1. 定义不需要设置长度

2. make的初始化为 `nil`

3. [1,3] 取数学表达式[1,3}

4. appand() 追加