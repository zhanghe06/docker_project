#!/usr/bin/env bash

# 清理历史容器
docker rm -f selenium-hub node-chrome node-firefox

# 更新最新镜像
docker pull selenium/hub
docker pull selenium/node-chrome
docker pull selenium/node-firefox

# 启动hub
docker run \
    -h selenium-hub \
    --name selenium-hub \
    -e GRID_TIMEOUT=30 \
    -p 4444:4444 \
    -d \
    selenium/hub

# 启动节点 chrome
docker run \
    -h node-chrome \
    --name node-chrome \
    --link selenium-hub:hub \
    -e NODE_MAX_INSTANCES=3 \
    -e NODE_MAX_SESSION=3 \
    -d \
    selenium/node-chrome

# 启动节点 firefox
docker run \
    -h node-firefox \
    --name node-firefox \
    --link selenium-hub:hub \
    -e NODE_MAX_INSTANCES=3 \
    -e NODE_MAX_SESSION=3 \
    -d \
    selenium/node-firefox
