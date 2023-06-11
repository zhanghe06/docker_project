#!/usr/bin/env bash

TOPIC=topic

curl -d 'hello world' 'http://127.0.0.1:4151/pub?topic='"${TOPIC}"

# 管理界面：http://127.0.0.1:4171
