#!/usr/bin/env bash

docker run \
    -h elasticsearch \
    --name elasticsearch \
    -d \
    --ulimit nofile=65536:65536 \
    -v "${PWD}/config/elasticsearch.yml":/usr/share/elasticsearch/config/elasticsearch.yml \
    -p 9200:9200 \
    -p 9300:9300 \
    -e ELASTIC_PASSWORD='123456' \
    docker.elastic.co/elasticsearch/elasticsearch:6.2.3

# Development mode
# docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.2.3

# Production mode
