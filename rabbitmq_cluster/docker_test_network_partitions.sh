#!/usr/bin/env bash

# 网络分区（脑裂）测试
# 模拟网络抖动

# https://www.rabbitmq.com/partitions.html

echo "断开容器网络"
# docker network disconnect -f <network_name> <container_name>
docker network disconnect -f rabbitmq_cluster rabbitmq01
docker network disconnect -f rabbitmq_cluster rabbitmq02
docker network disconnect -f rabbitmq_cluster rabbitmq03

echo "等待故障恢复"
# 模拟故障恢复时间，满足网络分区条件（超过75秒）
sleep 80

echo "恢复容器网络"
# docker network connect <network_name> <container_name>
docker network connect rabbitmq_cluster rabbitmq01
docker network connect rabbitmq_cluster rabbitmq02
docker network connect rabbitmq_cluster rabbitmq03

# 如果出现网络分区，原因是rabbitmq集群网络分区处理策略的默认配置是忽略

# 手动处理（当集群故障处理策略为默认配置 cluster_partition_handling = ignore 时需要手动处理）
# docker exec -it rabbitmq01 sh -c "rabbitmqctl stop_app && rabbitmqctl start_app"
# docker exec -it rabbitmq02 sh -c "rabbitmqctl stop_app && rabbitmqctl start_app"
# docker exec -it rabbitmq03 sh -c "rabbitmqctl stop_app && rabbitmqctl start_app"

# 如果策略为，故障恢复后，则不会出现网络分区
