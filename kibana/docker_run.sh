#!/usr/bin/env bash

docker run \
    -h kibana \
    --name kibana \
    -v "${PWD}/config/kibana.yml":/usr/share/kibana/config/kibana.yml \
    -p 5601:5601 \
    -d \
    docker.elastic.co/kibana/kibana:5.5.0
