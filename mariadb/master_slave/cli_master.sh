#!/usr/bin/env bash

node=master

docker run \
    -it \
    --link mariadb_$node:mysql \
    --rm \
    mariadb:10.8 \
    sh -c 'exec mysql \
    -h"$MYSQL_PORT_3306_TCP_ADDR" \
    -P"$MYSQL_PORT_3306_TCP_PORT" \
    -uroot \
    -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" \
    --default-character-set=utf8 \
    "$MYSQL_ENV_MYSQL_DATABASE"'

# SELECT @@global.gtid_binlog_pos;
