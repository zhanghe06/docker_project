#!/usr/bin/env bash

# docker load -i python_2.7.18.tar.gz

docker build \
    --rm=true \
    -t proxy:latest \
    -f Dockerfile .
