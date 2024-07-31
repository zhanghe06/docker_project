#!/usr/bin/env bash

# 参考：Elasticsearch也可以用作向量数据库 https://mp.weixin.qq.com/s/Umj8wxTFGATLWSatEQsChg

# 创建索引
curl http://localhost:9200/neural_index/ -XPUT -H 'Content-Type: application/json' -d '{
"mappings": {
    "properties": {
        "general_text_vector": {
            "type": "dense_vector",
            "dims": 384,
            "index": true,
            "similarity": "cosine"
        },
        "general_text": {
            "type": "text"
        },
        "color": {
            "type": "text"
        }
    }
}}'

# 检查索引
curl -XGET http://localhost:9200/neural_index

# 创建文档
curl http://localhost:9200/neural_index/_bulk -XPOST -H 'Content-Type: application/json' -d '
{"index": {"_id": "0"}}
{"general_text": "The presence of communication amid scientific minds was equally important to the success of the Manhattan Project as scientific intellect was. The only cloud hanging over the impressive achievement of the atomic researchers and engineers is what their success truly meant; hundreds of thousands of innocent lives obliterated.", "general_text_vector": [0.0367823, 0.072423555, ..., 0.0054274425], "color": "black"}
'

# 文档统计
curl -XGET http://localhost:9200/_cat/indices
curl -XGET http://localhost:9200/_cat/count/neural_index?v

# 文档搜索（精确的 kNN，耗时，准确）
curl http://localhost:9200/neural_index/_search -XPOST -H 'Content-Type: application/json' -d '{
"query": {
    "script_score": {
        "query" : {
            "match_all": {}
        },
        "script": {
            "source": "cosineSimilarity(params.queryVector, '\''general_text_vector'\'') + 1.0",
            "params": {
                "queryVector": [-9.01364535e-03, -7.26634488e-02, ..., -1.16323479e-01]
            }
        }
    }
}}'

# 文档搜索（近似的 kNN，快速，近似）
curl http://localhost:9200/neural_index/_search -XPOST -H 'Content-Type: application/json' -d '{
"knn": {
    "field": "general_text_vector",
    "query_vector": [-9.01364535e-03, -7.26634488e-02, ..., -1.16323479e-01],
    "k": 3,
    "num_candidates": 10
},
"_source": [
    "general_text",
    "color"
]}'
