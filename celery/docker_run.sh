#!/usr/bin/env bash

docker run \
        --link some-rabbit:rabbit \
        --name some-celery \
        -d \
        celery:4.0.2
