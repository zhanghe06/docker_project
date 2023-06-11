#!/usr/bin/env bash

docker run \
  --rm \
  -v "$PWD":/usr/src/myapp \
  -w /usr/src/myapp \
  -e GOOS=windows \
  -e GOARCH=386 \
  golang:1.20 go build -v
