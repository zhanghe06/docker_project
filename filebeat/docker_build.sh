#!/usr/bin/env bash

docker build \
        --rm=true \
        -t filebeat \
        -f Dockerfile .
