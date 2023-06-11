#!/usr/bin/env bash

mkdir -p $PWD/data

# docker run -d --name clickhouse-server --ulimit nofile=262144:262144 yandex/clickhouse-server

docker run \
    -d \
    --name clickhouse-server \
    --ulimit nofile=262144:262144 \
    --volume=$PWD/data:/var/lib/clickhouse \
    -p 8123:8123 \
    -p 9000:9000 \
    -p 9009:9009 \
    yandex/clickhouse-server

# 修改 /etc/clickhouse-server/config.xml 中 65行 注释去掉<listen_host>::</listen_host>
#     --volume=$PWD/config.xml:/etc/clickhouse-server/config.xml \
