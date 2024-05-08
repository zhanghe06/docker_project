#!/usr/bin/env bash


docker run -d \
  --name=openvpn-as \
  --cap-add=NET_ADMIN \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Asia/Shanghai \
  -e INTERFACE=eth0 \
  -p 943:943 \
  -p 9443:9443 \
  -p 1194:1194/udp \
  -v ${PWD}/config:/config \
  --restart unless-stopped \
  ghcr.io/linuxserver/openvpn-as


#docker run -d \
#  --name=openvpn-as \
#  --cap-add=NET_ADMIN \
#  -e PUID=1000 \
#  -e PGID=1000 \
#  -e HOST_ADDR=$(curl -s https://api.ipify.org) \
#  -p 943:943 \
#  -p 9443:9443 \
#  -p 1194:1194/udp \
#  --restart unless-stopped \
#  ghcr.io/linuxserver/openvpn-as





  -v ${PWD}/config:/config \
