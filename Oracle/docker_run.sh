#!/usr/bin/env bash

# https://github.com/vittorioexp/oracledb-docker-container

docker run \
  --name oracle19c \
  --restart always \
  -p 1521:1521 \
  -p 5500:5500 \
  -e ORACLE_PDB=orcl \
  -e ORACLE_PWD=password \
  -e INIT_SGA_SIZE=3000 \
  -e INIT_PGA_SIZE=1000 \
  -v ${PWD}/data:/opt/oracle/oradata \
  -d \
  oracle/database:19.3.0-ee



#docker run \
#  --name oracle19c \
#  --restart always \
#  -p 1521:1521 \
#  -p 5500:5500 \
#  -e ORACLE_PDB=orcl \
#  -e ORACLE_PWD=password \
#  -e INIT_SGA_SIZE=3000 \
#  -e INIT_PGA_SIZE=1000 \
#  -v /opt/oracle/oradata \
#  -d \
#  oracle/database:19.3.0-ee
