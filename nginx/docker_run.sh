#!/usr/bin/env bash

docker run \
    -h nginx \
    --name nginx \
    -v `pwd`/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v `pwd`/conf/ssl:/etc/nginx/ssl:ro \
    -v `pwd`/conf/conf.d:/etc/nginx/conf.d:ro \
    -v `pwd`/log:/var/log/nginx \
    -p 80:80 \
    -p 443:443 \
    -d \
    nginx:1.13.0
