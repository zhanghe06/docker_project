# busybox

[https://hub.docker.com/_/busybox](https://hub.docker.com/_/busybox)

什么是 BusyBox？嵌入式 Linux 的瑞士军刀

BusyBox 的磁盘大小在 1 到 5 Mb 之间（取决于变体），是制作节省空间的发行版的非常好的组成部分。

为二进制文件创建 Dockerfile
```
FROM busybox
COPY ./my-static-binary /my-static-binary
CMD ["/my-static-binary"]
```
