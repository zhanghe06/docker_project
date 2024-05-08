# Harbor

[https://github.com/goharbor/harbor](https://github.com/goharbor/harbor)

```
# 下载bitnami官方压缩包
wget https://github.com/bitnami/containers/archive/main.tar.gz

# 解压
tar zxvf main.tar.gz

# 将harbor-portal目录移动到我们的当前目录
mv containers-main/bitnami/harbor-portal .
 
cd harbor-portal
 
# 启动portal
docker-compose up
```

## 安装指南

https://blog.csdn.net/mo_sss/article/details/135909921

https://goharbor.io/docs/latest/install-config/


```
wget https://github.com/goharbor/harbor/releases/download/v2.10.2-rc1/harbor-offline-installer-v2.10.2-rc1.tgz
tar xzvf harbor-offline-installer-v2.10.2-rc1.tgz
cd harbor
cp harbor.yml.tmpl harbor.yml
./prepare
./install.sh
docker-compose -f docker-compose.yml ps
```


http://<my_registry_domain>
```
账号：admin
密码：Harbor12345
```

```
docker login <my_registry_domain>
```

新建私有项目：test

```
docker tag nginx:1.24-alpine <my_registry_domain>/test/nginx:1.24-alpine
docker push <my_registry_domain>/test/nginx:1.24-alpine
```

```
docker logout  # 注销Docker Hub
docker logout <my_registry_domain> # 注销私有仓库
```

```
docker login <my_registry_domain> -u admin -p Harbor12345 && docker pull <my_registry_domain>/test/nginx:1.24-alpine && docker logout <my_registry_domain>
```
