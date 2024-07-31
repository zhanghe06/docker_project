#!/usr/bin/env bash

docker run \
  -d \
  -h=gotenberg \
  --name=gotenberg \
  -p 3030:3000 \
  gotenberg/gotenberg:8

#docker run -d --name=gotenberg_3031 -p 3031:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3032 -p 3032:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3033 -p 3033:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3034 -p 3034:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3035 -p 3035:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3036 -p 3036:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3037 -p 3037:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3038 -p 3038:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3039 -p 3039:3000 gotenberg/gotenberg:8
#docker run -d --name=gotenberg_3040 -p 3040:3000 gotenberg/gotenberg:8
