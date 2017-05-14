#!/usr/bin/env bash

docker run \
    -it \
    --link redis:redis \
    --rm \
    redis:3.0.7 \
    redis-cli -h redis -p 6379
