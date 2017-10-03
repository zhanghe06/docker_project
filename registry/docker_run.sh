#!/usr/bin/env bash

docker run \
    -h registry \
    --name registry \
    -v ${PWD}/data:/var/lib/registry \
    -p 5000:5000 \
    --restart always \
    -d \
    registry:2
