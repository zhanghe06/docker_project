#!/usr/bin/env bash

TOPIC=topic

# 消费指定topic/channel，写入一个新的按行分隔的文件，可滚动和压缩文件
docker exec -it nsqd nsq_to_file  \
  --topic="${TOPIC}" --channel=archive \
  --output-dir=/tmp/archive \
  --nsqd-tcp-address=127.0.0.1:4150

# 管理界面：http://127.0.0.1:4171
