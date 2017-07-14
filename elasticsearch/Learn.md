## elasticsearch 学习过程

- 适用版本：elasticsearch 5.5.0
- 测试工具：kibana 5.5.0 Dev Tools

基本数据类型：

[Field datatypes](https://www.elastic.co/guide/en/elasticsearch/reference/5.5/mapping-types.html)

说明：

1. 很多教程使用 filtered，ES 5.0 已弃用，被 bool/must/filter 替代。

2. datatype：Object（对象） 与 Nested（嵌套） 区别

都是层次结构，Object 适用单个 json 对象，Nested 适用一组 json 对象

Lucene 没有内部对象的概念，所以 Elasticsearch 将对象层次结构变成一个简单的字段名称和值列表。

```
# 索引文档
PUT /megacorp/employee/1
{
    "first_name" : "John",
    "last_name" :  "Smith",
    "age" :        25,
    "about" :      "I love to go rock climbing",
    "interests": [ "sports", "music" ]
}
PUT /megacorp/employee/2
{
    "first_name" :  "Jane",
    "last_name" :   "Smith",
    "age" :         32,
    "about" :       "I like to collect rock albums",
    "interests":  [ "music" ]
}
PUT /megacorp/employee/3
{
    "first_name" :  "Douglas",
    "last_name" :   "Fir",
    "age" :         35,
    "about":        "I like to build cabinets",
    "interests":  [ "forestry" ]
}

# 检索文档
GET /megacorp/employee/1

# 检索文档部分数据
GET /megacorp/employee/1?_source=first_name,last_name,age

# 查询字符串(query string)搜索
GET /megacorp/employee/_search?q=last_name:Smith

# DSL查询(Query DSL)
GET /megacorp/employee/_search
{
    "query": {
        "match": {
            "last_name": "Smith"
        }
    }
}

# 组合搜索
GET /megacorp/employee/_search
{
    "query": {
        "bool": {
            "must": [
                {
                    "match": {
                        "last_name": "smith"
                    }
                },
                {
                    "range": {
                        "age": {
                            "gte": 30
                        }
                    }
                }
            ]
        }
    }
}

# 全文搜索
GET /megacorp/employee/_search
{
    "query": {
        "match": {
            "about": "rock climbing"
        }
    }
}

# 短语搜索(以下命中，标准分析器会丢弃大部分的标点符号)
GET /megacorp/employee/_search
{
    "query": {
        "match_phrase": {
            "about": "rock climbing"
        }
    }
}
GET /megacorp/employee/_search
{
    "query": {
        "match_phrase": {
            "about": "rock + climbing"
        }
    }
}
# 短语搜索(不能命中，短语顺序不符)
GET /megacorp/employee/_search
{
    "query": {
        "match_phrase": {
            "about": "climbing rock"
        }
    }
}

# 高亮搜索
GET /megacorp/employee/_search
{
    "query": {
        "match_phrase": {
            "about": "rock climbing"
        }
    },
    "highlight": {
        "fields": {
            "about": {}
        }
    }
}

# 聚合查询 - 平均年龄
GET /megacorp/employee/_search
{
    "aggs": {
        "avg_age": {
            "avg": {"field": "age"}
        }
    }
}
# 聚合查询 - 年龄分布
GET /megacorp/employee/_search
{
    "aggs": {
        "ages": {
            "terms": { "field": "age" }
        }
    }
}
# 聚合查询 - 兴趣分布（interests为数组，注意需要使用keyword）
GET /megacorp/employee/_search
{
    "aggs": {
        "all_interests": {
            "terms": {"field": "interests.keyword"}
        }
    }
}
# 聚合查询 - 条件筛选+兴趣分布（interests为数组，注意需要使用keyword）
GET /megacorp/employee/_search
{
    "query": {
        "match": {
            "last_name": "smith"
        }
    },
    "aggs": {
        "all_interests": {
            "terms": {"field": "interests.keyword"}
        }
    }
}
# 聚合查询 - 每种兴趣下职员的平均年龄（interests为数组，注意需要使用keyword）
{
    "aggs": {
        "all_interests": {
            "terms": {"field": "interests.keyword"},
            "aggs": {
                "avg_age": {
                    "avg": {"field": "age"}
                }
            }
        }
    }
}
```

关联查询

[Joining queries](https://www.elastic.co/guide/en/elasticsearch/reference/current/joining-queries.html)

```
# 新建索引 - 公司信息
PUT /recruitment/company/1
{
    "company_name": "Shanghai East Yanan Road Foreign Trade Co.,Ltd.",
    "scale":        100,
    "fax":          "021-8888-6666",
    "address":      "Level 10, No.700, East Yanan Road, Huangpu District, Shanghai, P. R. China"
}
PUT /recruitment/company/2
{
    "company_name": "Shanghai West Yanan Road Foreign Trade Co.,Ltd.",
    "scale":        500,
    "fax":          "021-8888-8888",
    "address":      "Level 10, No.700, West Yanan Road, Huangpu District, Shanghai, P. R. China"
}
PUT /recruitment/company/3
{
    "company_name": "Shanghai Tianmu West Road Foreign Trade Co.,Ltd.",
    "scale":        200,
    "fax":          "021-8888-0000",
    "address":      "Level 10, No.1500, Tianmu West Road, Jingan District, Shanghai, P. R. China"
}
# 新建索引map - 职位信息
# 注意：薪资范围使用 integer_range，否则，后续插入会默认成嵌套格式
PUT /recruitment
{
    "mappings": {
        "position": {
            "properties": {
                "company_id": {
                    "type": "long"
                },
                "title": {
                    "type": "text"
                },
                "salary": {
                    "type": "integer_range"
                },
                "pub_time": {
                    "type": "date",
                    "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
                }
            }
        }
    }
}
# 新建索引 - 职位信息
PUT /recruitment/position/1
{
    "company_id": 1,
    "title": "Junior JAVA",
    "salary": {
        "gte": 10000,
        "lte": 20000
    },
    "pub_time": "2017-01-01"
}
PUT /recruitment/position/2
{
    "company_id": 1,
    "title": "Junior PHP",
    "salary": {
        "gte": 10000,
        "lte": 20000
    },
    "pub_time": "2017-02-01"
}
PUT /recruitment/position/3
{
    "company_id": 1,
    "title": "Senior PHP",
    "salary": {
        "gte": 20000,
        "lte": 40000
    },
    "pub_time": "2017-02-01"
}
PUT /recruitment/position/4
{
    "company_id": 2,
    "title": "Junior Python",
    "salary": {
        "gte": 10000,
        "lte": 20000
    },
    "pub_time": "2017-01-01"
}
PUT /recruitment/position/5
{
    "company_id": 2,
    "title": "Junior PHP",
    "salary": {
        "gte": 10000,
        "lte": 20000
    },
    "pub_time": "2017-03-01"
}
PUT /recruitment/position/6
{
    "company_id": 3,
    "title": "Senior JAVA",
    "salary": {
        "gte": 20000,
        "lte": 40000
    },
    "pub_time": "2017-02-01"
}

# 多匹配查询 - 查找 上海-黄浦 的招聘公司(上海的公司全部命中，黄浦区的相关性更高)
GET /recruitment/company/_search
{
  "query": {
    "multi_match": {
      "query": "shanghai huangpu", 
      "fields": ["company_name", "address"] 
    }
  }
}

# 应用级别的Join操作(分两步) - 查找上海-静安所有招聘职位
# 一、获取上海-静安地区所有公司id
GET /recruitment/company/_search
{
  "query": {
    "match": {
      "address": "jingan"
    }
  }
}
# 二、根据公司ID获取职位信息
GET /recruitment/position/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "terms": {
            "company_id": [3]
          }
        }
      ]
    }
  }
}

# 思考：查询使用java技术栈公司的所有职位

# 以上缺点：真实的世界中，第一个查询条件很可能会出现数百万结果，会让第二个查询语句变得非常庞大，并且第二个查询会执行数百万次 term 的查找
# 可以设计为以下扁平结构(嵌套结构)
```

嵌套查询

[Nested Query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-nested-query.html)

```
# 新建索引 - 包含公司信息嵌套结构的职位信息
PUT /recruitment/position/7
{
    "company_id": 3,
    "title": "Senior UI",
    "salary": {
        "gte": 20000,
        "lte": 40000
    },
    "company": {
        "id": 3,
        "name":     "Shanghai Tianmu West Road Foreign Trade Co.,Ltd.",
        "scale":    200,
        "fax":      "021-8888-0000",
        "address":  "Level 10, No.1500, Tianmu West Road, Jingan District, Shanghai, P. R. China"
    }
}

# 嵌套查询 - 查询上海-静安地区所有的UI职位
GET /recruitment/position/_search
{
    "query": {
        "bool": {
            "must": [
                {
                    "match": {"title": "ui"}
                },
                {
                    "match": {"company.address": "jingan"}
                }
            ]
        }
    }
}
```

范围查询
```
# 查询公司规模100-200的所有公司
GET /recruitment/company/_search
{
    "query": {
        "range": {
            "scale": {
                "gte": 100,
                "lte": 200
            }
        }
    }
}
# 查询薪资30000-50000的所有职位（会命中范围集合有交集的所有记录）
GET /recruitment/position/_search
{
    "query": {
        "range": {
            "salary": {
                "gte": 30000,
                "lte": 50000
            }
        }
    }
}
```

理解 text keyword

参考：https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-term-query.html
```
# 新建索引映射
PUT my_index
{
  "mappings": {
    "my_type": {
      "properties": {
        "full_text": {
          "type":  "text" 
        },
        "exact_value": {
          "type":  "keyword"
        }
      }
    }
  }
}

# 新建索引
PUT my_index/my_type/1
{
  "full_text":   "Quick Foxes!", 
  "exact_value": "Quick Foxes!"
}

# 命中
GET my_index/my_type/_search
{
  "query": {
    "term": {
      "exact_value": "Quick Foxes!"
    }
  }
}

# 没有命中
GET my_index/my_type/_search
{
  "query": {
    "term": {
      "full_text": "Quick Foxes!"
    }
  }
}

# 命中
GET my_index/my_type/_search
{
  "query": {
    "term": {
      "full_text": "foxes"
    }
  }
}

# 命中（适用全文检索）
GET my_index/my_type/_search
{
  "query": {
    "match": {
      "full_text": "Quick Foxes!"
    }
  }
}
```
