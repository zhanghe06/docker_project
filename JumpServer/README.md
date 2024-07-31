# JumpServer

https://www.jumpserver.org/

https://github.com/jumpserver/Dockerfile

[安装文档](https://docs.jumpserver.org/zh/master/install/setup_by_fast/)

```
mkdir jumpserver
cd jumpserver
git clone --depth=1 https://github.com/jumpserver/Dockerfile.git ./

cp config_example.conf .env
```

修改配置`.env`
```
# Web
HTTP_PORT=8080
```

部署服务
```
docker compose -f docker-compose-network.yml -f docker-compose-redis.yml -f docker-compose-mariadb.yml -f docker-compose-init-db.yml up -d
docker exec -i jms_core bash -c './jms upgrade_db'
docker compose -f docker-compose-network.yml -f docker-compose-redis.yml -f docker-compose-mariadb.yml -f docker-compose.yml up -d
```

```
ssh -p 2222 用户名@堡垒机IP 进行连接。
```

http://139.224.249.179:8080

admin/admin

重置为：手机号码

```
ssh -p 2222 <用户名>@<堡垒机IP>
ssh -p 2222 admin@139.224.249.179
```

关闭服务
```
docker compose stop
```

移除服务
```
docker compose down
```
