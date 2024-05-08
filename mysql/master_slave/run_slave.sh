#!/usr/bin/env bash

node=slave

mkdir -p $PWD/$node/log
mkdir -p $PWD/$node/data
mkdir -p $PWD/$node/conf

docker run \
  -d \
  -h mysql_$node \
  --name mysql_$node \
  -p 3326:3306 \
  --privileged=true \
  --restart=always \
  -e MYSQL_ROOT_PASSWORD='123456' \
  -e MYSQL_DATABASE='test' \
  -e MYSQL_USER='www' \
  -e MYSQL_PASSWORD='123456' \
  -e TZ=Asia/Shanghai \
  -v $PWD/$node/log:/var/log/mysql \
  -v $PWD/$node/data:/var/lib/mysql \
  -v $PWD/$node/conf:/etc/mysql/conf \
  mysql:5.7 \
  --server-id=2 \
  --log-bin \
  --binlog-format=ROW \
  --gtid_mode=ON \
  --enforce_gtid_consistency=ON \
  --log_slave_updates \
  --binlog-ignore-db=mysql \
  --character-set-server=utf8 \
  --collation-server=utf8_general_ci

# 在主从GTID方案中，binlog 建议使用 ROW 格式，因为它能够记录每个更改操作的具体内容。

# CHANGE MASTER TO MASTER_HOST='<master_host>', MASTER_PORT=3306, MASTER_USER='replication', MASTER_PASSWORD='password', MASTER_AUTO_POSITION=1;
# CHANGE MASTER TO MASTER_HOST='192.168.0.152', MASTER_PORT=3316, MASTER_USER='replication', MASTER_PASSWORD='password', MASTER_AUTO_POSITION=1;
