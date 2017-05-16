ElasticSearch
https://hub.docker.com/_/elasticsearch/
```
$ sudo docker pull elasticsearch:5.4.0
```

https://www.elastic.co/guide/cn/elasticsearch/guide/current/index.html

http://0.0.0.0:9200/_cluster/health

## plugin

https://github.com/mobz/elasticsearch-head

http://localhost:9100/

当出现 【集群健康值: 未连接】 时
elasticsearch/config/elasticsearch.yml
新增以下配置，重启 elasticsearch 容器
```
http.cors.enabled: true
http.cors.allow-origin: "*"
```
再次访问 http://localhost:9100/
【集群健康值: green (0 of 0)】
