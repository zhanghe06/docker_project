#!/usr/bin/env bash

docker run \
        --link rabbitmq:rabbit \
        --rm \
        celery:4.0.2 \
        celery status
