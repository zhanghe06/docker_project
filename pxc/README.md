# PXC (Percona XtraDB Cluster)

Percona XtraDB Cluster 是业界主流的 MySQL 集群方案，在性能上甚至可以比肩 MySQL 企业版。

最关键的一个特性：PXC 集群的 数据同步具有强一致性的特点。只支持 InnoDB 引擎

[官方镜像](https://hub.docker.com/r/percona/percona-xtradb-cluster)

下载 PXC 镜像
```
docker pull percona/percona-xtradb-cluster
docker tag percona/percona-xtradb-cluster pxc
docker rmi percona/percona-xtradb-cluster
```

创建主节点容器
```
docker run -d -p 9001:3306
    -e MYSQL_ROOT_PASSWORD=123456			# 数据库 root 密码
    -e CLUSTEER_NAME=PXC1
    -e XTRABACKUP_PASSWORD=123456			# pxc 集群之间数据同步的密码
    -v pnv1:/var/lib/mysql --privileged		# 数据卷的挂载
    --name=pn1		                        # 当前容器名称
    --net=swarm_mysql		                # 加入虚拟网络名称
    pxc			                            # 容器镜像
```

创建从节点容器
```
docker run -d -p 9001:3306
    -e MYSQL_ROOT_PASSWORD=123456			# 数据库 root 密码
    -e CLUSTEER_NAME=PXC1
    -e XTRABACKUP_PASSWORD=123456			# pxc 集群之间数据同步的密码
    -v pnv2:/var/lib/mysql --privileged		# 数据卷的挂载
    --name=pn2		                        # 当前容器名称
    --net=swarm_mysql		                # 加入虚拟网络名称
    pxc			                            # 容器镜像
```

数据卷操作
```
# 数据卷列表
docker volume ls
# 创建数据卷
docker volume create test
# 删除数据卷，如果挂载了容器，则不能删除；先删除容器，再删除数据卷
docker volume rm test
# 清除没有挂载的数据卷
docker volume prune
# 查看数据卷详情
docker volume inspect pnv1
```
