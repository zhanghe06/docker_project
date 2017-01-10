## 创建项目
```
✗ scrapy startproject app
✗ scrapy genspider ip_cn ip.cn
✗ scrapy crawl ip_cn
```


## 部署项目

更新配置
app/scrapy.cfg
```
[deploy]
url = http://localhost:6800/
project = app
```

启动服务
```
✗ scrapyd
```

部署项目
```
✗ scrapyd-deploy -p app
```

检查服务
```
✗ curl http://localhost:6800/daemonstatus.json
```

项目列表
```
✗ curl http://localhost:6800/listprojects.json
```

蜘蛛列表
```
✗ curl http://localhost:6800/listspiders.json?project=default
```

调度任务
```
# 注意：最新版 scrapyd 支持自定义 jobid
✗ curl http://localhost:6800/schedule.json -d project=default -d spider=ip_cn -d jobid=ip_cn_2016_12_29
```

查看任务
```
✗ curl http://localhost:6800/listjobs.json?project=default
```

取消任务
```
curl http://localhost:6800/cancel.json -d project=default -d job=ip_cn_2016_12_29
```

## 参考

https://doc.scrapy.org/en/latest/

http://scrapyd.readthedocs.io/en/latest
