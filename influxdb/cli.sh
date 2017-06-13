#!/usr/bin/env bash

docker run \
    --rm \
    --link=influxdb \
    -it \
    influxdb:1.2.4 \
    influx -host influxdb
