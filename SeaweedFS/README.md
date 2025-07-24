## SeaweedFS

https://github.com/chrislusf/seaweedfs

https://github.com/chrislusf/seaweedfs/releases/download/0.76/linux_amd64.tar.gz

https://hub.docker.com/r/chrislusf/seaweedfs

https://github.com/seaweedfs/seaweedfs/wiki/FUSE-Mount

https://github.com/seaweedfs/seaweedfs/wiki/WebDAV

https://raw.githubusercontent.com/chrislusf/seaweedfs/master/docker/seaweedfs-compose.yml

[SeaweedFS搭建与使用](https://blog.wangqi.love/articles/seaweedfs/seaweedfs%E6%90%AD%E5%BB%BA%E4%B8%8E%E4%BD%BF%E7%94%A8.html)

镜像
```
docker pull --platform linux/amd64 chrislusf/seaweedfs:3.68
docker save chrislusf/seaweedfs:3.68 | gzip > ./seaweedfs_3.68.tar.gz
docker load -i ./seaweedfs_3.68.tar.gz
```

测试
```
curl http://localhost:9333/dir/assign
{"fid":"3,01b5620b52","url":"172.18.0.3:8080","publicUrl":"172.18.0.3:8080","count":1}

curl -F file=@/root/my.png http://localhost:8080/3,01b5620b52
{"name":"my.png","size":80958,"eTag":"ebc4d22b"}

curl -X DELETE http://localhost:8080/3,01b5620b52
{"size":80976}

curl -i http://localhost:8080/3,01b5620b52
```

## 身份验证

生产应用中，需要在连接时提供用户名和密码。
SeaweedFS 不直接处理这些凭据，但您可以使用 Nginx 或 Apache 等 Web 服务器作为反向代理，并在这些服务器上配置身份验证。


## 接口

- [Filer Server API](https://github.com/seaweedfs/seaweedfs/wiki/Filer-Server-API)
