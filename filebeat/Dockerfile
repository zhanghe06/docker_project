FROM debian:jessie

MAINTAINER zh <zhang_he06@163.com>

RUN apt-get update && \
    apt-get install -y curl && \
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.4.3-amd64.deb && \
    dpkg -i filebeat-5.4.3-amd64.deb
