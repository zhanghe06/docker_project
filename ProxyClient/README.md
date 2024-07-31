# 科学上网

```
sshpass -p 'Medishare!2023' scp -r ./ root@192.168.0.159:/data1/proxy
```

```
ALL_PROXY=socks5://127.0.0.1:1080 docker pull --platform linux/amd64 python:3.10-alpine
docker save python:3.10-alpine | gzip > python_3.10-alpine.tar.gz
scp python_3.10-alpine.tar.gz ./ root@192.168.0.159:/data1/proxy

docker load -i python_3.10-alpine.tar.gz
```
测试
```
ALL_PROXY=socks5://127.0.0.1:1080 curl -L cip.cc
ALL_PROXY=http://127.0.0.1:8118 curl -L cip.cc
```


`/etc/docker/daemon.json`
```
{
  "registry-mirrors": [],
  "proxies": {
    "http-proxy": "http://<user>:<password>@<domain>:<port>",
    "https-proxy": "http://<user>:<password>@<domain>:<port>",
    "no-proxy": "<registry.domain>"
  }
}
```

```
systemctl restart docker
```


## alpine 镜像

rc-service is part of openrc, install openrc

apk add openrc --no-cache



## 调试

```
docker run --rm -it -v $PWD:/app python:3.10 bash
```
