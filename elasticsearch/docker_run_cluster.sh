#!/usr/bin/env bash

docker run \
    -h elasticsearch \
    --name elasticsearch \
    -d \
    --ulimit nofile=65536:65536 \
    -v "${PWD}/config/elasticsearch.yml":/usr/share/elasticsearch/config/elasticsearch.yml \
    -p 9200:9200 \
    -p 9300:9300 \
    docker.elastic.co/elasticsearch/elasticsearch:5.5.0
