#!/usr/bin/env bash

docker run \
    -h jenkins_blueocean \
    --name jenkins_blueocean \
    -v ${PWD}/jenkins_home_blueocean:/var/jenkins_home \
    -p 8080:8080 \
    -p 50000:50000 \
    -d \
    jenkinsci/blueocean
