#!/usr/bin/env bash

docker run \
        --name supervisor \
        -v ${PWD}/../code_project/supervisor_project:/supervisor_project \
        -d \
        -p 9001:9001 \
        supervisor \
        supervisord -c etc/supervisord.conf
