#!/usr/bin/env bash

docker run \
    -h logstash_syslog \
    --name logstash_syslog \
    --rm -it \
    -v "${PWD}/config/":/usr/share/logstash/config/ \
    -v "${PWD}/pipeline/":/usr/share/logstash/pipeline/ \
    -p 5149:5149/udp \
    docker.elastic.co/logstash/logstash:5.4.3 -f /usr/share/logstash/pipeline/logstash-syslog.conf
