# Ollama

https://hub.docker.com/r/ollama/ollama

https://ollama.com/blog/ollama-is-now-available-as-an-official-docker-image

https://ollama.com/library



命令行CLI启动模型（自动拉取）
```
ollama run llama2
ollama run llama2-chinese
```


docker 加载模型
```
docker exec -it ollama ollama run llama2
```

拉取模型
```
ollama pull llama2
ollama pull llama2-chinese
ollama pull mistral
ollama pull meditron
ollama pull qwen
```

服务Server
```
OLLAMA_HOST=0.0.0.0:11434 ollama serve
```

## Open WebUI (Formerly Ollama WebUI)

https://github.com/open-webui/open-webui

镜像加速
```
docker pull ghcr.io/open-webui/open-webui:main
替换为：
docker pull ghcr.dockerproxy.com/open-webui/open-webui:main

docker tag ghcr.dockerproxy.com/open-webui/open-webui:main ghcr.io/open-webui/open-webui:main
```

Open WebUI 容器的安装
```
docker run -d -p 3000:8080 \
    --add-host=host.docker.internal:host-gateway \
    -v open-webui:/app/backend/data \
    --name open-webui \
    --restart always \
    ghcr.io/open-webui/open-webui:main
```

Open WebUI 在远程的安装
```
docker run -d -p 3000:8080 \
    -e OLLAMA_BASE_URL=https://example.com \
    -v open-webui:/app/backend/data \
    --name open-webui \
    --restart always \
    ghcr.io/open-webui/open-webui:main
```

http://localhost:3000

macOS 环境

```
# 终端1
OLLAMA_HOST=0.0.0.0:11434 ollama serve

# 终端2（cli模式）
ollama run llama2-chinese

# 终端2（web模式）
docker run -d -p 3000:8080 \
    -e OLLAMA_BASE_URL=http://172.17.205.114:11434 \
    -v open-webui:/app/backend/data \
    --name open-webui \
    --restart always \
    ghcr.io/open-webui/open-webui:main
```

生产环境

/etc/systemd/system/ollama.service
```
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
Environment="OLLAMA_HOST=0.0.0.0"
Environment="PATH=/home/dtjk/bin:/home/dtjk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/dtjk/.dotnet/tools:/home/dtjk/.dotnet/tools"

[Install]
WantedBy=default.target
```

```
sudo systemctl daemon-reload
sudo service ollama restart
```

## API接口

https://github.com/ollama/ollama/blob/main/docs/api.md


生成响应
```
curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt": "为什么天空是蓝色的？"
}'
```

与模型聊天
```
curl http://localhost:11434/api/chat -d '{
  "model": "mistral",
  "messages": [
    { "role": "user", "content": "为什么天空是蓝色的？" }
  ]
}'
```

## 开源基座大模型对比

https://zhuanlan.zhihu.com/p/680260131

llama2、Mistral、baichuan2和qwen


## 大模型微调

FastChat

Deepspeed

原理：打标签？
