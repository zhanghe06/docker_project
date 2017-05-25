#!/usr/bin/env bash

docker run \
    -h kibana \
    --name kibana \
    --link elasticsearch:elasticsearch \
    -p 5601:5601 \
    -d \
    kibana:5.4.0
