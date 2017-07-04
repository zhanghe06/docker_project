#!/usr/bin/env bash

docker run \
    -h filebeat \
    --name filebeat \
    -d \
    -v "${PWD}/config/filebeat.yml":/etc/filebeat/filebeat.yml \
    filebeat \
    sh -c "/usr/bin/filebeat.sh"
