#!/usr/bin/env bash

docker run \
        --hostname my-rabbit \
        --name some-rabbit \
        -d \
        rabbitmq:3.6.6
