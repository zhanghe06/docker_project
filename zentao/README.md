# 禅道部署

- 官网 [https://www.zentao.net/](https://www.zentao.net/)
- 使用Docker方式安装部署禅道 [https://developer.aliyun.com/article/924185](https://developer.aliyun.com/article/924185)

```
docker search zentao
docker pull hub.zentao.net/app/zentao:latest
```

使用内置数据库（失败）
```
docker run -d \
    --name zentao \
    --restart always \
    -p 18080:80 \
    -v /data2/docker/zentao/data:/data \
    -e MYSQL_INTERNAL=true \
    hub.zentao.net/app/zentao:latest
```

使用外部数据库（成功）
```
docker run -d \
    --name zentao \
    --restart always \
    -p 18080:80 \
    -v /data2/docker/zentao/data:/data \
    -e MYSQL_INTERNAL=false \
    -e ZT_MYSQL_HOST=192.168.0.159 \
    -e ZT_MYSQL_PORT=3306 \
    -e ZT_MYSQL_USER=root \
    -e ZT_MYSQL_PASSWORD=mixi123456 \
    -e ZT_MYSQL_DB=zentao \
    hub.zentao.net/app/zentao:latest
```

安装向导：[http://192.168.0.159:18080/install.php](http://192.168.0.159:18080/install.php)

配置信息已经成功保存到" /apps/zentao/config/my.php "中。您后面还可继续修改此文件。

巨坑：
到 [第4步](http://192.168.0.159:18080/install.php?m=install&f=step4) 无法进行下一步，直接手工改参数`f=step5`，进入 [第5步](http://192.168.0.159:18080/install.php?m=install&f=step5)

```
公司名称：公司名称
管理账号：admin
管理密码：1qaz@WSX
```
