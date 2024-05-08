#!/usr/bin/env bash

docker run \
  -d \
  -h=gotenberg \
  --name=gotenberg \
  -p 3030:3000 \
  gotenberg/gotenberg:8
