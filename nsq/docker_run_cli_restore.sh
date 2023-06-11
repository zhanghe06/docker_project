#!/usr/bin/env bash

TOPIC=topic

# https://pkg.go.dev/github.com/propellerads/nsq/apps/to_nsq#section-readme
# 从 stdin 发布到 nsq 主题数据的工具。
# 适用场景：测试消息、临时通知

docker exec -it nsqd to_nsq  \
  --topic="${TOPIC}" \
  --nsqd-tcp-address=127.0.0.1:4150

# 管理界面：http://127.0.0.1:4171
