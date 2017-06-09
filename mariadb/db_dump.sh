#!/usr/bin/env bash

docker exec mariadb \
    sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > backup/all-databases.sql
