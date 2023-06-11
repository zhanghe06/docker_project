# Redis

[https://hub.docker.com/_/redis/](https://hub.docker.com/_/redis/)

```
$ sudo docker pull redis:3.2.8
```

## 主从配置

至少3个节点: 1主2从

## 集群配置

至少6个节点: 3主3从


## 主从测试

主节点（读; 写）：
```
redis-cli -h 192.168.4.1 -p 6380
192.168.4.1:6380> KEYS *
(empty list or set)
192.168.4.1:6380> SET a 123
OK
192.168.4.1:6380> GET a
"123"
```

从节点01（读; 写,失败）
```
redis-cli -h 192.168.4.1 -p 6381
192.168.4.1:6381> KEYS *
1) "a"
192.168.4.1:6381> SET b 456
(error) READONLY You can't write against a read only slave.
```

从节点02（读; 写,失败）
```
redis-cli -h 192.168.4.1 -p 6382
192.168.4.1:6382> KEYS *
1) "a"
192.168.4.1:6382> SET b 456
(error) READONLY You can't write against a read only slave.
```


## 集群测试

```bash
redis-cli -h 192.168.4.1 -p 6380
192.168.4.1:6380> CLUSTER INFO  # 查看集群状态
192.168.4.1:6380> CLUSTER NODES  # 查看集群节点
```

虚拟槽的分配
https://my.oschina.net/zhangxufeng/blog/905611
