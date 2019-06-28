#!/usr/bin/env bash

docker run \
    --name cfy_manager_local \
    -d \
    --restart unless-stopped \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --tmpfs /run \
    --tmpfs /run/lock \
    --security-opt seccomp:unconfined \
    --cap-add SYS_ADMIN \
    -p 80:80 \
    -p 8000:8000 \
    cloudifyplatform/community:18.10.4
