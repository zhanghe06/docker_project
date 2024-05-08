#!/usr/bin/env bash

# docker network create elastic
# --net elastic \

docker run \
    -h elasticsearch \
    --name elasticsearch \
    -d \
    --ulimit nofile=65536:65536 \
    -p 9200:9200 \
    -p 9300:9300 \
    -e cluster.initial_master_nodes=elasticsearch \
    -e discovery.seed_hosts=elasticsearch \
    -e ELASTIC_PASSWORD='123456' \
    -e xpack.security.enabled=false \
    -e xpack.security.http.ssl.enabled=false \
    docker.elastic.co/elasticsearch/elasticsearch:8.8.2

# https://www.elastic.co/guide/en/elasticsearch/reference/8.8/docker.html


# 生成集群节点的token
# docker exec -it elasticsearch /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node
