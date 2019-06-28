#!/usr/bin/env bash

MASTER_IP='192.168.4.1'
MASTER_PORT=6380

SLAVE_01_IP='192.168.4.1'
SLAVE_02_IP='192.168.4.1'

SLAVE_01_PORT=6381
SLAVE_02_PORT=6382

[ -d ${PWD}/data/master ] || mkdir -p ${PWD}/data/master
[ -d ${PWD}/data/slave_${SLAVE_01_PORT} ] || mkdir -p ${PWD}/data/slave_${SLAVE_01_PORT}
[ -d ${PWD}/data/slave_${SLAVE_02_PORT} ] || mkdir -p ${PWD}/data/slave_${SLAVE_02_PORT}


docker run \
    -h redis_master \
    --name redis_master \
    -v ${PWD}/data/master/:/data \
    -p ${MASTER_PORT}:6379 \
    -d \
    redis:3.2.8 \
    redis-server


docker run \
    -h redis_slave_${SLAVE_01_PORT} \
    --name redis_slave_${SLAVE_01_PORT} \
    -v ${PWD}/data/slave_${SLAVE_01_PORT}/:/data \
    -p ${SLAVE_01_PORT}:6379 \
    -d \
    redis:3.2.8 \
    redis-server --slaveof ${MASTER_IP} ${MASTER_PORT}


docker run \
    -h redis_slave_${SLAVE_02_PORT} \
    --name redis_slave_${SLAVE_02_PORT} \
    -v ${PWD}/data/slave_${SLAVE_02_PORT}/:/data \
    -p ${SLAVE_02_PORT}:6379 \
    -d \
    redis:3.2.8 \
    redis-server --slaveof ${MASTER_IP} ${MASTER_PORT}
