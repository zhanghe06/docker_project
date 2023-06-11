#!/usr/bin/env bash

docker run \
    -h nginx \
    --name nginx \
    -v ${PWD}/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v ${PWD}/conf/ssl:/etc/nginx/ssl:ro \
    -v ${PWD}/conf/conf.d:/etc/nginx/conf.d:ro \
    -v ${PWD}/log:/var/log/nginx \
    -p 80:80 \
    -p 443:443 \
    -d \
    nginx:1.13.0

# 注意这里挂载设置了:ro只读，宿主机更新文件之后，会直接更新到docker内，而容器内的修改不会影响宿主机
