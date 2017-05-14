#!/usr/bin/env bash

docker run \
    -h redis \
    --name redis \
    -v `pwd`/data:/data \
    -p 6379:6379 \
    -d \
    redis:3.0.7 \
    redis-server --appendonly yes
