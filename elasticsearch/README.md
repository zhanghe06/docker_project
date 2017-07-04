## elasticsearch

https://github.com/elastic/elasticsearch

https://github.com/elastic/elasticsearch-docker/tree/5.4

https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker

The default password for the elastic user is changeme
username = elastic
password = changeme

```
$ sudo docker pull docker.elastic.co/elasticsearch/elasticsearch:5.4.3
```


## 生产环境注意事项
[生产环境注意事项](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_notes_for_production_use_and_defaults)


查看集群状态
```
➜  elasticsearch git:(master) ✗ curl -u elastic http://127.0.0.1:9200/_cat/health
Enter host password for user 'elastic':
1499098552 16:15:52 es-cluster yellow 1 1 3 3 0 0 3 0 - 50.0%
```
