# NSQ

[https://hub.docker.com/r/nsqio/nsq](https://hub.docker.com/r/nsqio/nsq)

[https://nsq.io/deployment/docker.html](https://nsq.io/deployment/docker.html)

[https://nsq.io/components/nsqd.html](https://nsq.io/components/nsqd.html)

[https://nsq.io/components/utilities.html](https://nsq.io/components/utilities.html)

参考: https://www.cnblogs.com/shanyou/p/4296181.html

```
docker pull nsqio/nsq
```

优势：
1. NSQ提倡分布式和分散的拓扑，没有单点故障，支持容错和高可用性，并提供可靠的消息交付保证
2. NSQ支持横向扩展，没有任何集中式代理
3. NSQ易于配置和部署，并且内置了管理界面

缺陷：NSQ集群可以保证服务的高可用，但是没法保证Topic消息的高可用

架构：

- nsqd 是一个接收、排队、然后转发消息到客户端的进程。
- nsqlookupd 管理拓扑信息并提供最终一致性的发现服务。
- nsqadmin 用于实时查看集群的统计数据（并且执行各种各样的管理任务）。

NSQ中的数据流模型是由streams和consumers组成的tree。  
topic 是一种独特的stream。  
channel 是一个订阅了给定topic的consumers 逻辑分组。

集群模式下，通过 nsqlookupd 查询到 nsqd 地址，再连接，可以部署多台，防止单点故障
非集群环境，直接连接指定 nsqd

## 可靠性保证

1. 消息在生产者到NSQD 的传输过程中丢失

如果NSQD收到一条生产者消息，会返回一个OK的标识符，应用可以根据该标识进行重发处理。

2. NSQD丢失了数据

开启持久化数据选项，当NSQD重启之后，自动从硬盘加载数据，进行恢复，但可能导致少量数据丢失，此处可以跟 OK标识符结合起来，只有消息被持久化到磁盘之后，才会给客户端返回OK标识，所以哪怕NSQD在数据持久化之前挂了，数据丢了，由于生产者未收到OK标识符，也是可以进行重发的。

3. 消费者丢失了数据

NSQD使用了FIN标识符，当NSQD把消息PUSH给消费者的同时，也会将消息放入inFlight队列中，当消费者成功处理了消息之后，会给NSQD返回FIN标识符，NSQD将inFlight队列中响应消息删除，否则将会重新入队，再次进行投递。


## topic channel

- 多个消费者指定相同channel名称，消息会负载均衡到其中的一个消费者
- 同一topic下创建多个不同channel，生产发送对应topic的消息，这些channel均能接收到消息

## 特性

- 消息默认不持久化，可以配置成持久化模式。nsq采用的方式时内存+硬盘的模式，当内存到达一定程度时就会将数据持久化到硬盘。
  - 如果将`--mem-queue-size`设置为0，所有的消息将会存储到磁盘。
  - 服务器重启时也会将当时在内存中的消息持久化。
- 每条消息至少传递一次。
- 消息不保证有序。

## 延时队列

nsq支持延时消息的投递

默认支持最大的毫秒数为3600000毫秒也就是60分钟，不过这个值可以在nsqd启动的时候用`-max-req-timeout`参数修改最大值。

kafka不支持延时消息的投递，目前知道支持的有：rabbitmq、rocketmq

但是rabbitmq有坑，有可能会超时投递，而rocketmq只有阿里云付费版支持的比较好。

## 生产配置

[https://nsq.io/deployment/production.html](https://nsq.io/deployment/production.html)

建议nsqd与生成消息的服务在同一地点运行


## 服务端与客户端的关系

消费者有两种方式与nsqd建立连接：
1. 消费者直连nsqd，这是最简单的方式，缺点是nsqd服务无法实现动态伸缩了
2. 消费者通过http查询nsqlookupd获取该nsqlookupd上所有nsqd的连接地址，然后再分别和这些nsqd建立连接(官方推荐的做法)

生产者必须直连nsqd去投递message  
官方推荐使用[VIP](https://github.com/nsqio/go-nsq/issues/170)解决高可用问题，[https://nsq.io/overview/faq.html](https://nsq.io/overview/faq.html)


nsqlookupd
- tcp(默认端口4160)管理nsqd服务
- http(默认端口4161)管理nsqadmin服务

nsqd
- tcp端口(4150)
- http端口(4151)以及一个可选的https端口

## 高可用配置

方案一：
在多个nsqd实例中，配置相同的Topic和Channel
弊端：消息重复，消费端需要保证幂等；需要往每个nsqd实例都消息投递；配置同名的Channel不够灵活

方案二：
nsq_to_file
