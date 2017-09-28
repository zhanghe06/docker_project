#!/usr/bin/env bash

docker run \
    -h memcached \
    --name memcached \
    -p 11211:11211 \
    -d \
    memcached:1.5.1
