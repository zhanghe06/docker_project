#!/usr/bin/env bash

docker run \
  -d \
  -p 5236:5236 \
  --restart=always \
  --name dm8_01 \
  --privileged=true \
  -e PAGE_SIZE=16 \
  -e LD_LIBRARY_PATH=/opt/dmdbms/bin \
  -e INSTANCE_NAME=dm8_01 \
  -v "${PWD}/data":/opt/dmdbms/data \
  dm8_single:v8.1.2.128_ent_x86_64_ctm_pack4
