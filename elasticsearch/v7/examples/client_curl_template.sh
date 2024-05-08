#!/usr/bin/env bash

# https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html
# https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-term-query.html#query-dsl-term-query

#ES_HOSTNAME='elasticsearch'
ES_HOSTNAME='127.0.0.1'
ES_PORT=9200
ES_USERNAME='elastic'
ES_PASSWORD='changeme'

# 查看模板列表
# curl -u elastic:changeme -X GET "localhost:9200/_template?pretty"
# 查看模板详情
# curl -u elastic:changeme -X GET "localhost:9200/_template/template_01,template_02?pretty"
# 删除指定模板
# curl -u elastic:changeme -X DELETE "localhost:9200/_template/template_01?pretty"
curl -u ${ES_USERNAME}:${ES_PASSWORD} -X DELETE "${ES_HOSTNAME}:${ES_PORT}/_template/template_01?pretty"

# 创建模板
# curl -u elastic:changeme -X PUT "localhost:9200/_template/template_01?pretty" -H 'Content-Type: application/json' -d'
curl -u ${ES_USERNAME}:${ES_PASSWORD} -X PUT "${ES_HOSTNAME}:${ES_PORT}/_template/template_01?pretty" -H 'Content-Type: application/json' -d'
{
  "index_patterns": ["robot-*", "robots-*"],
  "settings": {
    "number_of_shards": 1
  },
  "mappings": {
    "_source": {
      "enabled": true
    },
    "properties": {
      "host_name": {
        "type": "keyword"
      },
      "line_name": {
        "type": "keyword"
      },
      "q_name": {
        "type": "keyword"
      },
      "q_name_delay": {
        "type": "keyword"
      },
      "qty": {
        "type": "integer"
      },
      "qty_delay": {
        "type": "integer"
      },
      "time": {
        "type": "date",
        "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
      }
    }
  }
}
'
