#!/usr/bin/env bash

docker run \
    -h elasticsearch \
    --name elasticsearch \
    -d \
    -v "${PWD}/config/elasticsearch.yml":/usr/share/elasticsearch/config/elasticsearch.yml \
    -v "${PWD}/data":/usr/share/elasticsearch/data \
    -v "${PWD}/logs":/usr/share/elasticsearch/logs \
    -p 9200:9200 \
    -p 9300:9300 \
    elasticsearch:5.4.0
