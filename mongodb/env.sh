#!/usr/bin/env bash

docker run \
    -it \
    --link mongo:mongo \
    --rm \
    mongo:3.6 \
    env
