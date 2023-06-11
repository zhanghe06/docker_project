#!/usr/bin/env bash

# Step 1: Create a network
docker network create app-tier --driver bridge

# Step 2: Launch the Zookeeper server instance
docker run -d --name zookeeper-server \
    --network app-tier \
    -e ALLOW_ANONYMOUS_LOGIN=yes \
    bitnami/zookeeper:3.8

# Step 3: Launch the Apache Kafka server instance
docker run -d --name kafka-server \
    --network app-tier \
    -e ALLOW_PLAINTEXT_LISTENER=yes \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
    -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CLIENT:PLAINTEXT,EXTERNAL:PLAINTEXT \
    -e KAFKA_CFG_LISTENERS=CLIENT://:9092,EXTERNAL://:9093 \
    -e KAFKA_CFG_ADVERTISED_LISTENERS=CLIENT://kafka-server:9092,EXTERNAL://localhost:9093 \
    -e KAFKA_CFG_INTER_BROKER_LISTENER_NAME=CLIENT \
    -p 9093:9093 \
    bitnami/kafka:3.4

# Step 4（Option）: Launch a web UI for monitoring Apache Kafka clusters
docker run -d --name kafka-admin-ui \
    --network app-tier \
    -e KAFKA_BROKERCONNECT=kafka-server:9092 \
    -e JVM_OPTS="-Xms32M -Xmx64M" \
    -e SERVER_SERVLET_CONTEXTPATH="/" \
    -p 9000:9000 \
    obsidiandynamics/kafdrop:latest
