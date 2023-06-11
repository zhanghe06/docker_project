#!/usr/bin/env bash

version=6.2

[ -d ${PWD}/data ] || mkdir -p ${PWD}/data

docker run \
    -h redis \
    --name redis \
    -v ${PWD}/data:/data \
    -p 6379:6379 \
    -d \
    redis:${version} \
    redis-server
