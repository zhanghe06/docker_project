## etcd

https://coreos.com/etcd/docs/latest/

https://github.com/coreos/etcd/blob/master/Documentation/op-guide/container.md#docker

https://github.com/coreos/etcd

https://yeasy.gitbooks.io/docker_practice/content/etcd/

测试容器
```
# 查看服务端版本
✗ docker exec etcd /bin/sh -c "/usr/local/bin/etcd --version"
etcd Version: 3.2.6
Git SHA: 9d43462
Go Version: go1.8.3
Go OS/Arch: linux/amd64

# 查看客户端版本
✗ docker exec etcd /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl version"
etcdctl version: 3.2.6
API version: 3.2

# 获取健康状态
✗ docker exec etcd /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl endpoint health"
127.0.0.1:2379 is healthy: successfully committed proposal: took = 724.335µs

# 设置配置
✗ docker exec etcd /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl put foo bar"
OK

# 获取配置
✗ docker exec etcd /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl get foo"
foo
bar

# 列出集群成员
✗ docker exec etcd /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl member list"
90759d18ce3e162c, started, node1, http://192.168.4.1:2380, http://192.168.4.1:2379
```

权限配置

https://coreos.com/etcd/docs/latest/v2/authentication.html


集群配置

https://github.com/coreos/etcd/blob/master/Documentation/op-guide/clustering.md
