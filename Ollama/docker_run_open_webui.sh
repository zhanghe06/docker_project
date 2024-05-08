#!/usr/bin/env bash

docker run -d -p 3000:8080 \
    -e OLLAMA_BASE_URL=http://172.17.205.114:11434 \
    -v open-webui:/app/backend/data \
    --name open-webui \
    --restart always \
    ghcr.io/open-webui/open-webui:main
