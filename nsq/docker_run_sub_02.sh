#!/usr/bin/env bash

TOPIC=topic

# 消费指定topic/channel，并写入到标准输出中
docker exec -it nsqlookupd nsq_tail \
  --topic="${TOPIC}" --channel=chan_2 \
  --lookupd-http-address=127.0.0.1:4161

# 管理界面：http://127.0.0.1:4171
