#!/usr/bin/env bash

docker run \
    -h=cadvisor \
    --name=cadvisor \
    -v /:/rootfs:ro \
    -v /var/run:/var/run:rw \
    -v /sys:/sys:ro \
    -v /var/lib/docker/:/var/lib/docker:ro \
    -p 8080:8080 \
    -d \
    google/cadvisor:latest
