#!/usr/bin/env bash

NODE_IP=${1:-192.168.4.1}

REGISTRY=quay.io/coreos/etcd

ETCD_VERSION=latest

DATA_DIR=${PWD}/data

docker run \
    -h etcd \
    --name etcd \
    -d \
    -p 2379:2379 \
    -p 2380:2380 \
    -v ${DATA_DIR}:/etcd-data \
    ${REGISTRY}:${ETCD_VERSION} \
    /usr/local/bin/etcd \
    --data-dir=/etcd-data --name node1 \
    --initial-advertise-peer-urls http://${NODE_IP}:2380 --listen-peer-urls http://0.0.0.0:2380 \
    --advertise-client-urls http://${NODE_IP}:2379 --listen-client-urls http://0.0.0.0:2379 \
    --initial-cluster node1=http://${NODE_IP}:2380

# sh docker_run.sh 192.168.64.169

# [http://127.0.0.1:2379/health](http://127.0.0.1:2379/health)
