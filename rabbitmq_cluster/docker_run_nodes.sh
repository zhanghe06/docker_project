#!/usr/bin/env bash

MQ_TAG=3.12

# 创建网络
docker network create rabbitmq_cluster

# 创建节点

# RabbitMQ Cluster 01 主节点
docker run -d \
  -h node01 \
  --name rabbitmq01 \
  --network rabbitmq_cluster \
  -v "${PWD}/data_01":/var/lib/rabbitmq \
  -v "${PWD}/conf/rabbitmq.conf":/etc/rabbitmq/rabbitmq.conf \
  -p 15672:15672 \
  -p 5672:5672 \
  -e RABBITMQ_NODENAME=rabbit \
  -e RABBITMQ_ERLANG_COOKIE='rabbitmq_cookie' \
  rabbitmq:${MQ_TAG}-management

# RabbitMQ Cluster 02 从节点
docker run -d \
  -h node02 \
  --name rabbitmq02 \
  --network rabbitmq_cluster \
  -v "${PWD}/data_02":/var/lib/rabbitmq \
  -v "${PWD}/conf/rabbitmq.conf":/etc/rabbitmq/rabbitmq.conf \
  -p 15673:15672 \
  -p 5673:5672 \
  -e RABBITMQ_NODENAME=rabbit \
  -e RABBITMQ_ERLANG_COOKIE='rabbitmq_cookie' \
  rabbitmq:${MQ_TAG}-management

# RabbitMQ Cluster 03 从节点
docker run -d \
  -h node03 \
  --name rabbitmq03 \
  --network rabbitmq_cluster \
  -v "${PWD}/data_03":/var/lib/rabbitmq \
  -v "${PWD}/conf/rabbitmq.conf":/etc/rabbitmq/rabbitmq.conf \
  -p 15674:15672 \
  -p 5674:5672 \
  -e RABBITMQ_NODENAME=rabbit \
  -e RABBITMQ_ERLANG_COOKIE='rabbitmq_cookie' \
  rabbitmq:${MQ_TAG}-management

# 说明
# -e RABBITMQ_NODENAME=rabbit 为默认值
