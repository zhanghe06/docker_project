#!/usr/bin/env bash

CLUSTER_01_IP='0.0.0.0'
CLUSTER_02_IP='0.0.0.0'
CLUSTER_03_IP='0.0.0.0'

CLUSTER_01_PORT=6381
CLUSTER_02_PORT=6382
CLUSTER_03_PORT=6383

[ -d ${PWD}/data/cluster_${CLUSTER_01_PORT} ] || mkdir -p ${PWD}/data/cluster_${CLUSTER_01_PORT}
[ -d ${PWD}/data/cluster_${CLUSTER_02_PORT} ] || mkdir -p ${PWD}/data/cluster_${CLUSTER_02_PORT}
[ -d ${PWD}/data/cluster_${CLUSTER_03_PORT} ] || mkdir -p ${PWD}/data/cluster_${CLUSTER_03_PORT}


docker run \
    -h redis_cluster_${CLUSTER_01_PORT} \
    --name redis_cluster_${CLUSTER_01_PORT} \
    -v ${PWD}/data/cluster_${CLUSTER_01_PORT}/:/data \
    -p ${CLUSTER_01_PORT}:6379 \
    -d \
    redis:3.2.8 \
    redis-server --cluster-enabled yes


docker run \
    -h redis_cluster_${CLUSTER_02_PORT} \
    --name redis_cluster_${CLUSTER_02_PORT} \
    -v ${PWD}/data/cluster_${CLUSTER_02_PORT}/:/data \
    -p ${CLUSTER_02_PORT}:6379 \
    -d \
    redis:3.2.8 \
    redis-server --cluster-enabled yes


docker run \
    -h redis_cluster_${CLUSTER_03_PORT} \
    --name redis_cluster_${CLUSTER_03_PORT} \
    -v ${PWD}/data/cluster_${CLUSTER_03_PORT}/:/data \
    -p ${CLUSTER_03_PORT}:6379 \
    -d \
    redis:3.2.8 \
    redis-server --cluster-enabled yes
