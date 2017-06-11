#!/usr/bin/env bash

docker run \
    -it \
    --rm \
    --link postgres:postgres \
    postgres:9.6.3 \
    env
