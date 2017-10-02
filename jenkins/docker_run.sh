#!/usr/bin/env bash

docker run \
    -h jenkins \
    --name jenkins \
    -v ${PWD}/jenkins_home:/var/jenkins_home \
    -p 8080:8080 \
    -p 50000:50000 \
    -d \
    jenkins/jenkins:lts
