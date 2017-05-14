https://hub.docker.com/r/selenium/hub/

拉取镜像
```
docker pull selenium/standalone-chrome
```

启动容器
```
docker run -d -P --name selenium-chrome selenium/standalone-chrome
或
docker run -d -p 4444:4444 --name selenium-chrome selenium/standalone-chrome
```

http://0.0.0.0:4444/wd/hub/


## todo

是否支持并行多任务
