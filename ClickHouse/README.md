# ClickHouse

ClickHouse 是俄罗斯最大的搜索引擎公司Yandex开发的一个开源的面向列的数据库管理系统，允许实时生成分析数据报告。

[https://github.com/ClickHouse/ClickHouse](https://github.com/ClickHouse/ClickHouse)

[https://hub.docker.com/r/yandex/clickhouse-server](https://hub.docker.com/r/yandex/clickhouse-server)

9000端口，用于接受客户端请求

9009端口，用于集群复制数据

8123端口，http请求端口

第一种方式(连接本地): /etc/init.d/clickhouse-client

第二种方式(连接远程): /etc/init.d/clickhouse-client --host=… --port=… --user=… --password=…

登录后, 其基本操作采用类SQL的方式即可使用, 但需要注意, 在建表时候, 需要开启多行查询, 否则建表时候会报错

开启多行查询的方式:

clickhouse-client -m  或者:  clickhouse-client --multiline

## 集群

双节点集群方案:

clickhouse1: 实例1, 端口: tcp 9000, http 8123, 同步端口9009, 类型: 分片1, 副本1

clickhouse1: 实例2, 端口: tcp 9001, http 8124, 同步端口9010, 类型: 分片2, 副本2 (clickhouse2的副本)

clickhouse2: 实例1, 端口: tcp 9000, http 8123, 同步端口9009, 类型: 分片2, 副本1

clickhouse2: 实例2, 端口: tcp 9001, http 8124, 同步端口9010, 类型: 分片1, 副本2 (clickhouse1的副本)

参考: [https://www.cnblogs.com/freeweb/p/9352947.html](https://www.cnblogs.com/freeweb/p/9352947.html)
