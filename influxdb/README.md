InfluxDB

https://hub.docker.com/_/influxdb/

```
$ sudo docker pull influxdb:1.2.4
```


生成默认配置文件
```
$ docker run --rm influxdb:1.2.4 influxd config > conf/influxdb.conf
```
