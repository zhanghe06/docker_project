# 达梦数据库

[Docker 安装](https://eco.dameng.com/document/dm/zh-cn/start/dm-install-docker.html)

[Docker 安装包](https://eco.dameng.com/download/)

```
docker load -i dm8_20220822_rev166351_x86_rh6_64_ctm.tar
docker images | grep dm8
docker run -d -p 5236:5236 --restart=always --name dm8_01 --privileged=true -e PAGE_SIZE=16 -e LD_LIBRARY_PATH=/opt/dmdbms/bin -e INSTANCE_NAME=dm8_01 -v /data/dm8_01:/opt/dmdbms/data dm8_single:v8.1.2.128_ent_x86_64_ctm_pack4
```

注意
1. 如果使用 docker 容器里面的 disql，进入容器后，先执行 source /etc/profile 防止中文乱码。
2. 新版本 Docker 镜像中数据库默认用户名/密码为 SYSDBA/SYSDBA001。

## DataGrip 连接达梦数据库

[DataGrip 连接达梦数据库](https://eco.dameng.com/community/article/c572d68874e9e696ee72ff9ef6972209)

[达梦数据驱动 DmJdbcDriver18](https://jar-download.com/artifact-search/DmJdbcDriver18)

Goland 配置达梦数据驱动过程：
```
Database > + Driver
User Drivers > Name: DM
Driver Files > + Custom JARs...
General Class: dm.jdbc.driver.DmDriver
```
