#!/usr/bin/env bash

# 重置密码（新密码自动生成，直接输出到终端）
docker exec -it elasticsearch sh -c "echo y | /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic"
