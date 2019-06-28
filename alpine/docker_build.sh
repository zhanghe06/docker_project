#!/usr/bin/env bash

docker build \
        --rm=true \
        -t alpine_cn \
        -f Dockerfile .
