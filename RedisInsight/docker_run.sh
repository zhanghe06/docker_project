#!/usr/bin/env bash


mkdir -p redisinsight
chown -R 1001 redisinsight

docker run \
  -h redis_insight \
  --name redis_insight \
  -v redisinsight:/db \
  -p 8001:8001 \
  -d \
  redislabs/redisinsight:1.12.0
