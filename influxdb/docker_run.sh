#!/usr/bin/env bash

docker run \
    -h=influxdb \
    --name=influxdb \
    -v $PWD:/var/lib/influxdb \
    -p 8086:8086 \
    -d \
    influxdb:1.2.4
