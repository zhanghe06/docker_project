#!/usr/bin/env bash

mkdir -p data

wget -c https://petstore.swagger.io/v2/swagger.json -O data/swagger.json

docker run \
    -h swagger-ui \
    --name swagger-ui \
    -d \
    -p 80:8080 \
    -e BASE_URL=/swagger \
    -e SWAGGER_JSON=/data/swagger.json \
    -v ${PWD}/data:/data \
    swaggerapi/swagger-ui

# 访问 http://127.0.0.1/swagger/
