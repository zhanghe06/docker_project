## 生成配置 etc/supervisord.conf
```
echo_supervisord_conf > etc/supervisord.conf
```

## 修改配置 etc/supervisord.conf
设置 nodaemon=true （非守护运行） 否则容器不能后台运行
```
[supervisord]
...
nodaemon=true
```

supervisor 网络服务
```
;[inet_http_server]         ; inet (TCP) server disabled by default
;port=127.0.0.1:9001        ; (ip_address:port specifier, *:port for all iface)
;username=user              ; (default is no username (open server))
;password=123               ; (default is no password (open server))
```
修改为
```
[inet_http_server]
port=0.0.0.0:9001
username=user
password=123
```

可以关闭 unix_http_server
```
;[unix_http_server]
;file=/tmp/supervisor.sock   ; (the path to the socket file)
```

supervisor 控制台
```
[supervisorctl]
serverurl=unix:///tmp/supervisor.sock ; use a unix:// URL  for a unix socket
;serverurl=http://127.0.0.1:9001 ; use an http:// url to specify an inet socket
;username=chris              ; should be same as http_username if set
;password=123                ; should be same as http_password if set
```
修改为：
```
[supervisorctl]
serverurl=http://0.0.0.0:9001
username=user
password=123
```


## 基础镜像
```
docker pull python:2.7.12
```

## 准备Dockerfile
```
docker run --name supervisor --rm=true -it python:2.7.12 bash
```

## 构建镜像
```
docker build --rm=true -t supervisor .
```

## 后台启动
```
docker run \
        --name supervisor \
        -v `pwd`/../code_project/supervisor_project:/supervisor_project \
        -d \
        -p 9001:9001 \
        supervisor \
        supervisord -c etc/supervisord.conf
```

## 交互启动
```
# 开启新的容器终端（不映射代码）
docker run --name supervisor --rm=true -it supervisor bash

# 进入运行中的容器终端
docker exec -it supervisor bash

# 开启新的容器终端（映射代码、端口）
docker run \
        --name supervisor \
        --rm=true \
        -v `pwd`/../code_project/supervisor_project:/supervisor_project \
        -it \
        -p 9001:9001 \
        supervisor \
        bash
```
