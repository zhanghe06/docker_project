## 基本概念
- 镜像（image）
- 容器（Container）
- 仓库（Repository）
- Docker Compose


## 基本命令
```
docker help
docker info
docker search
docker pull && docker push
docker build
docker images
docker rmi
docker run
docker rm
```


## 参考资料

https://hub.docker.com

https://docs.docker.com


## 注意事项

1、尽量不用 --link，容器启动有顺序，与 --restart=always 不能一起使用

2、docker 容器中的进程有时会生成 pid 文件，需要先 docker stop 把容器停掉，再用 docker commit 创建镜像，否则会把 pid 文件一起提交，这样从新镜像运行容器时，容器可能因为已经存在 pid 文件而无法启动。

3、docker 容器的 hosts 文件，在正在运行的容器 用docker exec 进入修改 /etc/hosts 文件，这个容器被重启后会发现 hosts文件会被还原。所以不要直接修改hosts文件，需要增加hosts，在docker run时 用 --add-host 参数。


