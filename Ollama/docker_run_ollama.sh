#!/usr/bin/env bash

docker run -d \
  -v ollama:/root/.ollama \
  -p 11434:11434 \
  --name ollama \
  --restart always \
  ollama/ollama

# 拉取医疗模型
# docker exec -it ollama ollama pull meditron
docker exec -it ollama ollama run meditron
