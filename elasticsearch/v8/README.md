# Elasticsearch

[Install Elasticsearch with Docker](https://www.elastic.co/guide/en/elasticsearch/reference/8.8/docker.html)

```
docker pull docker.elastic.co/elasticsearch/elasticsearch:8.8.2
```

## 部署服务

```
docker network create elastic
docker run --name es-node01 --net elastic -p 9200:9200 -p 9300:9300 -t docker.elastic.co/elasticsearch/elasticsearch:8.8.2
```

默认启用安全设置，服务启动后会有如下信息:
```
✅ Elasticsearch security features have been automatically configured!
✅ Authentication is enabled and cluster connections are encrypted.

ℹ️  Password for the elastic user (reset with `bin/elasticsearch-reset-password -u elastic`):
  72+atep6F*v8FyqpK6xw

ℹ️  HTTP CA certificate SHA-256 fingerprint:
  0e9acbaba6c25859f5c228c162479cb00389f29fabf776cb0ee25c37cb5756ce

ℹ️  Configure Kibana to use this cluster:
• Run Kibana and click the configuration link in the terminal when Kibana starts.
• Copy the following enrollment token and paste it into Kibana in your browser (valid for the next 30 minutes):
  eyJ2ZXIiOiI4LjguMSIsImFkciI6WyIxNzIuMjcuMC4yOjkyMDAiXSwiZmdyIjoiMGU5YWNiYWJhNmMyNTg1OWY1YzIyOGMxNjI0NzljYjAwMzg5ZjI5ZmFiZjc3NmNiMGVlMjVjMzdjYjU3NTZjZSIsImtleSI6InpsRGdzNGdCdEFqRFNfbWpQeHF2OlJIZjVJNkJwU3dhbk8wcmhLaUE5NFEifQ==

ℹ️ Configure other nodes to join this cluster:
• Copy the following enrollment token and start new Elasticsearch nodes with `bin/elasticsearch --enrollment-token <token>` (valid for the next 30 minutes):
  eyJ2ZXIiOiI4LjguMSIsImFkciI6WyIxNzIuMjcuMC4yOjkyMDAiXSwiZmdyIjoiMGU5YWNiYWJhNmMyNTg1OWY1YzIyOGMxNjI0NzljYjAwMzg5ZjI5ZmFiZjc3NmNiMGVlMjVjMzdjYjU3NTZjZSIsImtleSI6IjBGRGdzNGdCdEFqRFNfbWpQeHExOnVRWjRpUjdBUTgySVJFaTk1MzVNWkEifQ==

  If you're running in Docker, copy the enrollment token and run:
  `docker run -e "ENROLLMENT_TOKEN=<token>" docker.elastic.co/elasticsearch/elasticsearch:8.8.1`
```

```
docker run -e "ENROLLMENT_TOKEN=eyJ2ZXIiOiI4LjguMSIsImFkciI6WyIxNzIuMjcuMC4yOjkyMDAiXSwiZmdyIjoiMGU5YWNiYWJhNmMyNTg1OWY1YzIyOGMxNjI0NzljYjAwMzg5ZjI5ZmFiZjc3NmNiMGVlMjVjMzdjYjU3NTZjZSIsImtleSI6IjBGRGdzNGdCdEFqRFNfbWpQeHExOnVRWjRpUjdBUTgySVJFaTk1MzVNWkEifQ==" docker.elastic.co/elasticsearch/elasticsearch:8.8.1
```

## 集群管理插件 

[https://github.com/mobz/elasticsearch-head](https://github.com/mobz/elasticsearch-head)

8.x 版本禁用安全设置后，也是可以使用的

## 集群健康

单节点有时候会出现集群状态不健康，一般是副本没有分片导致，可以取消副本
```
curl 'http://localhost:9200/wechat_gzh_index/_settings' -X PUT -H "Content-Type: application/json" -d '{"number_of_replicas":"0"}'
```
