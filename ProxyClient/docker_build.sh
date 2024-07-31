#!/usr/bin/env bash

docker build \
    --rm=true \
    -t proxy:latest \
    -f Dockerfile .
