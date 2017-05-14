#!/usr/bin/env bash

docker run \
    --name nginx \
    -v /some/content:/usr/share/nginx/html:ro \
    -d \
    nginx:1.13.0
