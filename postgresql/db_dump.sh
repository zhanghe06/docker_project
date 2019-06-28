#!/usr/bin/env bash

backup_file_name=`date '+%Y%m%d%H%M%S'`'.sql'

docker exec postgres \
    sh -c "exec pg_dump -h postgres -p 5432 -U www -W -d project -f backup/${backup_file_name}"
