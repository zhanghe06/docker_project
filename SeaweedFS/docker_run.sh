#!/usr/bin/env bash

docker network create fs_seaweed

mkfir -p $PWD/data/master $PWD/data/volume

docker run \
    -h fs_master \
    --name fs_master \
    --network fs_seaweed \
    --restart always \
    -d \
    -p 9333:9333 \
    -p 19333:19333 \
    -p 9324:9324 \
    -v $PWD/data/master:/data \
    chrislusf/seaweedfs:3.68 \
    master -ip=fs_master -ip.bind=0.0.0.0 -metricsPort=9324
# 参数说明：
# -mdir="/data"       存储元数据的目录（默认）

docker run \
    -h fs_volume \
    --name fs_volume \
    --network fs_seaweed \
    --restart always \
    -d \
    -p 8080:8080 \
    -p 18080:18080 \
    -p 9325:9325 \
    -v $PWD/data/volume:/data \
    chrislusf/seaweedfs:3.68 \
    volume -mserver="fs_master:9333" -ip.bind=0.0.0.0 -port=8080  -metricsPort=9325
# 参数说明：
# -dir="/data"        存储数据文件的目录（默认）
# -rack="rack1"       机架名称
# -dataCenter="dc1"   数据中心名称
# -max=0              卷数量，默认值7，表示8个卷，单个卷可容纳32GiB，也就是单个文件最大支持32GiB

docker run \
    -h fs_filer \
    --name fs_filer \
    --network fs_seaweed \
    --restart always \
    -d \
    -p 8888:8888 \
    -p 18888:18888 \
    -p 9326:9326 \
    -v $PWD/data/filer:/data \
    chrislusf/seaweedfs:3.68 \
    filer -master="fs_master:9333" -ip.bind=0.0.0.0 -metricsPort=9326

docker run \
    -h fs_webdav \
    --name fs_webdav \
    --network fs_seaweed \
    --restart always \
    -d \
    -p 7333:7333 \
    -v $PWD/data/webdav:/data \
    chrislusf/seaweedfs:3.68 \
    webdav -filer="fs_filer:8888"
# 一、挂载到MacOS
# 1、Open "Finder" > "Go" > "Connect to Server"
# 2、Enter the URL of the filer, Format: http://<filerHost>:<filerPort>
# 3、Connect as "Guest"
# 4、Connected! Now you can operate the files as normal files.

# 二、挂载到Windows
# 1、打开“此电脑”或“计算机”窗口。
# 2、在窗口上方的菜单栏中，点击“计算机”或“此电脑”，然后选择“映射网络驱动器”。
# 3、在弹出的对话框中，选择一个可用的驱动器字母，然后输入网盘服务的WebDAV访问地址。
# 4、点击“完成”按钮，系统会提示你输入用户名和密码，输入网盘服务的认证信息。
# 5、成功映射后，你可以在“此电脑”或“计算机”窗口中看到一个新的驱动器，里面包含了网盘的内容。


# 生成安全配置模板
# weed scaffold -config=security


# 安全组规则：
# 9333、8080、8888、7333
