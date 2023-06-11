# RabbitMQ

RabbitMQ集群模式有两种：
一、普通集群

消息是分布的

优点: 高性能
缺点: 消息需要持久化，才能保证故障自愈后不丢消息

二、镜像队列

在普通模式的基础上，实现高可用

优点: 高可用
缺点: 性能低


普通集群模式是为了提高扩展性，镜像队列模式提高可用性。

最终方案：
- Keepalived 保证HAProxy的高可用
- HAProxy 保证RabbitMQ的高可用
- 镜像队列集群+全DISK存储模式

## 集群部署

```
sh docker_run_nodes.sh
```

等待半分钟左右，访问管理界面：

[http://0.0.0.0:15672/](http://0.0.0.0:15672/)

[http://0.0.0.0:15673/](http://0.0.0.0:15673/)

[http://0.0.0.0:15674/](http://0.0.0.0:15674/)

guest/guest

```
sh docker_run_join_cluster.sh
```

## 客户端库

官方客户端
```
go get github.com/rabbitmq/amqp091-go
```

集群连接需要自己实现: [https://github.com/rabbitmq/amqp091-go/discussions/137](https://github.com/rabbitmq/amqp091-go/discussions/137)

## 网络分区

[https://www.rabbitmq.com/partitions.html](https://www.rabbitmq.com/partitions.html)

出现网络分区对集群可用性的影响
1. 普通集群，无影响
2. 镜像队列，有影响

## 自定义配置

[https://www.rabbitmq.com/configure.html](https://www.rabbitmq.com/configure.html)

```
/etc/rabbitmq/conf.d/10-defaults.conf
/etc/rabbitmq/rabbitmq.conf
```
