#!/usr/bin/env bash

# docker load -i proxy_latest.tar.gz

docker run \
    -h proxy \
    --name proxy \
    --restart always \
    --privileged \
    -p 8118:8118 \
    -d \
    proxy \
    /sbin/init

sleep 3

docker exec -it proxy sh -c "systemctl restart kcp-client && sleep 3 && sslocal -c /etc/shadowsocks.json --user nobody -d start && sleep 3 && systemctl restart privoxy && sleep 3 && ALL_PROXY=http://127.0.0.1:8118 curl -L cip.cc"
