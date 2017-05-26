#!/usr/bin/env bash

# 安装中文分词插件
if [ ! -d ${PWD}/plugins/ik ]
then
    mkdir -p ${PWD}/plugins/ik
    wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.4.0/elasticsearch-analysis-ik-5.4.0.zip -O ${PWD}/plugins/ik/elasticsearch-analysis-ik-5.4.0.zip
    unzip ${PWD}/plugins/ik/elasticsearch-analysis-ik-5.4.0.zip -d ${PWD}/plugins/ik
fi

# 启动容器
docker run \
    -h elasticsearch \
    --name elasticsearch \
    -d \
    -v "${PWD}/config/elasticsearch.yml":/usr/share/elasticsearch/config/elasticsearch.yml \
    -v "${PWD}/data":/usr/share/elasticsearch/data \
    -v "${PWD}/logs":/usr/share/elasticsearch/logs \
    -v "${PWD}/plugins":/usr/share/elasticsearch/plugins \
    -p 9200:9200 \
    -p 9300:9300 \
    elasticsearch:5.4.0
