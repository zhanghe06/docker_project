## 基础镜像
```
docker pull python:2.7.12
```

## 准备Dockerfile
```
docker run --name scrapyd --rm=true -it python:2.7.12 bash
```

## 构建镜像
```
docker build --rm=true -t scrapyd .
```

## 后台启动
```
docker run \
        --name scrapyd \
        -v ${PWD}/../code_project/scrapy_project:/scrapy_project \
        -d \
        -p 6800:6800 \
        scrapyd \
        /usr/local/bin/scrapyd
```

## 交互启动
```
# 开启新的容器终端（不映射代码）
docker run --name scrapyd --rm=true -it scrapyd bash

# 进入运行中的容器终端
docker exec -it scrapyd bash

# 开启新的容器终端（映射代码、端口）
docker run \
        --name scrapyd \
        --rm=true \
        -v ${PWD}/../code_project/scrapy_project:/scrapy_project \
        -it \
        -p 6800:6800 \
        scrapyd \
        bash
```
