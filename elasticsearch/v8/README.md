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

## Elasticsearch CURL命令

参考：https://www.cnblogs.com/xiaodf/p/10623266.html

```
# 查看集群状态
curl '127.0.0.1:9200/_cat/health?v'

# 获取集群节点列表
curl '127.0.0.1:9200/_cat/nodes?v'

# 查看所有index
curl -X GET 'http://127.0.0.1:9200/_cat/indices?v'

# 查询所有的index包含其所有的type
curl '127.0.0.1:9200/_mapping?pretty=true'

# 查询某个index下的所有type
curl '127.0.0.1:9200/test/_mapping?pretty=true'

# 查询某个index的所有数据
curl '127.0.0.1:9200/test/_search?pretty=true'

# 查询index下某个type类型的数据（index=test type=test_topic）
curl '127.0.0.1:9200/test/test_topic/_search?pretty=true'

# 查询index下某个type下id确定的数据（index=test type=test_topic id=3525）
curl '127.0.0.1:9200/test/test_topic/3525?pretty=true'

# 和sql一样的查询数据
curl "127.0.0.1:9200/test/_search" -d'
{
    "query": { "match_all": {} },
    "_source": ["account_number", "balance"],
    "sort": { "balance": { "order": "desc" },
    "from": 10,
    "size": 10
}
'

# 创建索引(index)
curl -X PUT '127.0.0.1:9200/test?pretty'

# 往index里面插入数据
curl -X PUT '127.0.0.1:9200/test/test_zhang/1?pretty' -d '{"name":"tom","age":18}'

# 修改数据
curl -X PUT '127.0.0.1:9200/test/test_zhang/1?pretty' -d '{"name":"pete","age":20}'

# 更新数据同时新增数据
curl -X POST '127.0.0.1:9200/test/test_zhang/1/_update?pretty' -d '{"doc":{"name":"Alice","age":18,"addr":"beijing"}}'

# 利用script更新数据
curl -X POST '127.0.0.1:9200/test/test_zhang/1/_update?pretty' -d '{"script": "ctx._source.age += 5"}'

# 删除记录
curl -X DELETE '127.0.0.1:9200/test/test_zhang/1'

# 删除索引
curl -X DELETE '127.0.0.1:9200/test'
```


## 插件

### IK中文分词插件

参考：
- [IK Analysis for Elasticsearch and OpenSearch](https://github.com/infinilabs/analysis-ik)
- [使用IK分词插件（analysis-ik）](https://help.aliyun.com/zh/es/user-guide/use-the-analysis-ik-plug-in?spm=a2c4g.11186623.0.0.557f63d9w0j01h)
- [Elasticsearch插件列表](https://portal.cloud.geely.com/doc/BES/s/1ke3oqnhp-GEELY_V310)

停用词词库

```
a、an、and、are、as、at、be、but、by、for、if、in、into、is、it、no、not、of、on、or、such、that、the、their、then、there、these、they、this、to、was、will、with
```

```
也、了、仍、从、以、使、则、却、又、及、对、就、并、很、或、把、是、的、着、给、而、被、让、在、还、比、等、当、与、于、但
```

### analysis-pinyin拼音分词插件

### ingest attachment插件

### 动态同义词插件

### 简繁体转换插件
