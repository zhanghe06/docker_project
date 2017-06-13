#!/usr/bin/env bash

docker run \
        --link rabbitmq:rabbit \
        --name celery \
        -d \
        celery:4.0.2
