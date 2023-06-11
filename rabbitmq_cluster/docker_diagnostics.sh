#!/usr/bin/env bash

# 诊断（用户查看配置文件位置信息）
docker exec -it rabbitmq01 sh -c "rabbitmq-diagnostics status"
