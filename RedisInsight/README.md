# RedisInsight

[Install Docker](https://docs.redis.com/latest/ri/installing/install-docker/)

```
docker pull redislabs/redisinsight
mkdir -p redisinsight
chown -R 1001 redisinsight
docker run -d -v redisinsight:/db -p 8001:8001 redislabs/redisinsight:latest
```

[http://localhost:8001](http://localhost:8001)


仅仅支持连接4.0及之后的服务器版本，因为Memeory命令是4.0才开始支持的
