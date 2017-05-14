#!/usr/bin/env bash

docker run \
    -h mariadb \
    --name mariadb \
    -v `pwd`/data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD='123456' \
    -p 3306:3306 \
    -d \
    mariadb:10.1.23
