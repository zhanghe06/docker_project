#!/usr/bin/env bash

#NSQ_NET=192.168.64.240
#NSQ_NET=192.168.1.2
NSQ_NET=192.168.64.217
NSQ_TAG=v1.2.1

# 拉取镜像
docker pull nsqio/nsq:${NSQ_TAG}

# 清理历史容器
docker rm -f nsqadmin nsqd nsqlookupd

# 启动 nsqlookupd
docker run \
    -h node-nsqlookupd \
    --name nsqlookupd \
    -d \
    -p 4160:4160 \
    -p 4161:4161 \
    nsqio/nsq:${NSQ_TAG} /nsqlookupd

# 启动 nsqd
docker run \
    -h node-nsqd \
    --name nsqd \
    -d \
    -p 4150:4150 \
    -p 4151:4151 \
    -v "${PWD}/data":/data \
    -v "${PWD}/archive":/tmp/archive \
    nsqio/nsq:${NSQ_TAG} /nsqd \
    --mem-queue-size=0 \
    --broadcast-address="${NSQ_NET}" \
    --lookupd-tcp-address="${NSQ_NET}:4160"

# 启动 nsqadmin
docker run \
    -h node-nsqadmin \
    --name nsqadmin \
    -d \
    -p 4171:4171 \
    nsqio/nsq:${NSQ_TAG} /nsqadmin \
    --lookupd-http-address="${NSQ_NET}:4161"

# 脚本说明[推荐]

# 支持MacOS、Linux等所有环境

# sh docker_run_alone.sh

# 管理界面：http://127.0.0.1:4171
