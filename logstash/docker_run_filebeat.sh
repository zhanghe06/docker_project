#!/usr/bin/env bash

docker run \
    -h logstash_filebeat \
    --name logstash_filebeat \
    --rm -it \
    -v "${PWD}/config/":/usr/share/logstash/config/ \
    -v "${PWD}/pipeline/":/usr/share/logstash/pipeline/ \
    -p 5044:5044 \
    docker.elastic.co/logstash/logstash:5.4.3 -f /usr/share/logstash/pipeline/logstash-filebeat.conf
