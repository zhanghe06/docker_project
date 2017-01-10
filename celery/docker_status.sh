#!/usr/bin/env bash

docker run \
        --link some-rabbit:rabbit \
        --rm \
        celery:4.0.2 \
        celery status
