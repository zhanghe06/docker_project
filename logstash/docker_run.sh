#!/usr/bin/env bash

docker run \
    -h logstash \
    --name logstash \
    -d \
    -v "${PWD}/config/":/usr/share/logstash/config/ \
    -v "${PWD}/pipeline/":/usr/share/logstash/pipeline/ \
    docker.elastic.co/logstash/logstash:5.4.3 -f /usr/share/logstash/pipeline/logstash-syslog.conf
