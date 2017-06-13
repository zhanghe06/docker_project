InfluxDB

https://hub.docker.com/_/influxdb/

```
$ sudo docker pull influxdb:1.2.4
```

疑问：
```
    -v ${PWD}:/var/lib/influxdb
```
挂载失败，啥原因？


默认配置文件
```
$ docker run --rm influxdb:1.2.4 influxd config > influxdb.conf
```
