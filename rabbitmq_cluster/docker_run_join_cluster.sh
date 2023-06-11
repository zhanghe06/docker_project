#!/usr/bin/env bash

# 创建集群
docker exec -it rabbitmq02 sh -c "rabbitmqctl stop_app && rabbitmqctl reset && rabbitmqctl join_cluster --ram rabbit@node01 && rabbitmqctl start_app"

docker exec -it rabbitmq03 sh -c "rabbitmqctl stop_app && rabbitmqctl reset && rabbitmqctl join_cluster --ram rabbit@node01 && rabbitmqctl start_app"

# 检测集群
docker exec -it rabbitmq01 sh -c "rabbitmqctl cluster_status"

# 设置镜像策略
# rabbitmqctl set_policy [-p Vhost] Name Pattern Definition [Priority]
# docker exec -it rabbitmq01 rabbitmqctl set_policy ha-all "^" '{"ha-mode":"all"}'


# 说明
# --ram表示设置为内存节点，忽略此参数默认为磁盘节点。
