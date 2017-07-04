#!/usr/bin/env bash

docker run \
    -d \
    --name filebeat \
    -v "${PWD}/config/filebeat.yml":/etc/filebeat/filebeat.yml \
    -v /var/lib/docker/containers:/var/lib/docker/containers \
    docker.elastic.co/beats/filebeat:5.4.3


# 参考 http://tonybai.com/2016/03/25/ship-docker-container-log-with-filebeat/
# 单独作为容器，需要考虑日志目录的挂载
