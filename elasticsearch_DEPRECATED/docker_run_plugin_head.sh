#!/usr/bin/env bash

docker run \
    -h elasticsearch-head \
    --name elasticsearch-head \
    -d \
    -p 9100:9100 \
    mobz/elasticsearch-head:5
