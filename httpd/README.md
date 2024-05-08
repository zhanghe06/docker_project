# httpd

https://hub.docker.com/_/httpd/
```
docker pull httpd:2.4
```

配置文件路径
```
/usr/local/apache2/conf/httpd.conf
```

SSL/HTTPS
```
server.crt
server.key
添加到以下目录中
/usr/local/apache2/conf/

并将以下配置
/usr/local/apache2/conf/httpd.conf
中的
#Include conf/extra/httpd-ssl.conf
注释删除

启动时，-p 443:443
```
    
访问 http://0.0.0.0

It works!
