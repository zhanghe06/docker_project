#!/usr/bin/env bash

docker run -d \
    --name=url_to_png \
    -p 3089:3089 \
    ghcr.dockerproxy.com/jasonraimondi/url-to-png
