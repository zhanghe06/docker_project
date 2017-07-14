#!/usr/bin/env bash

IP=$1
PORT=$2

ES_IP=${IP:-0.0.0.0}
ES_PORT=${PORT:-9200}

echo 'sh docker_run_url.sh' ${ES_IP} ${ES_PORT}

docker run \
    -h kibana \
    --name kibana \
    -e ELASTICSEARCH_URL=http://${ES_IP}:${ES_PORT} \
    -p 5601:5601 \
    -d \
    docker.elastic.co/kibana/kibana:5.5.0
