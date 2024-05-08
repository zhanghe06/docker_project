#!/usr/bin/env bash

docker run -d \
  --name=openvpn-as \
  --cap-add=NET_ADMIN \
  --restart unless-stopped \
  -e TZ=Asia/Shanghai \
  -p 943:943 \
  -p 443:443 \
  -p 1194:1194/udp \
  -v $PWD/config:/openvpn \
  openvpn/openvpn-as
