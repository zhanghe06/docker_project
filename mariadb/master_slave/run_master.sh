#!/usr/bin/env bash

node=master

mkdir -p $PWD/$node/log
mkdir -p $PWD/$node/data
mkdir -p $PWD/$node/conf

docker run \
  -d \
  -h mariadb_$node \
  --name mariadb_$node \
  -p 3316:3306 \
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
  mariadb:10.8 \
  --server-id=1 \
  --log-bin \
  --binlog-format=ROW \
  --character-set-server=utf8 \
  --collation-server=utf8_general_ci

# 在主从GTID方案中，binlog 建议使用 ROW 格式，因为它能够记录每个更改操作的具体内容。

# CREATE USER 'replication'@'%' IDENTIFIED BY 'password';
# GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';
# FLUSH PRIVILEGES;

# docker exec mariadb_master sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SELECT @@global.gtid_binlog_pos;"'
# docker exec mariadb_master sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SELECT * from mysql.user\G"'
