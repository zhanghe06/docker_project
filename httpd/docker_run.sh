#!/usr/bin/env bash

docker run \
    -h apache \
    --name apache \
    -v ${PWD}/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf \
    -v ${PWD}/htdocs/:/usr/local/apache2/htdocs/ \
    -p 80:80 \
    -d \
    httpd:2.4
