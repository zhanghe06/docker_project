https://hub.docker.com/_/celery/

docker pull celery:4.0.2


第一步，启动 rabbitmq 容器
```
cd rabbitmq
sh docker_run.sh
```

第二步，启动 celery 容器
```
cd celery
sh docker_run.sh
```

检查集群状态
```
sh docker_status.sh
```


## celery

最佳实践

http://docs.jinkan.org/docs/celery/userguide/tasks.html#task-best-practices
