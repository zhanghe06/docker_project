
Trusty 14.04 (LTS) 安装 Docker
```
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates
$ sudo apt-key adv \
               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
$ sudo apt-get update
$ apt-cache policy docker-engine
$ sudo apt-get install docker-engine
$ sudo service docker status
$ sudo service docker start
$ sudo docker run hello-world
```


Ubuntu version | Repository
--- | ---
Precise 12.04 (LTS) | deb https://apt.dockerproject.org/repo ubuntu-precise main
Trusty 14.04 (LTS) | deb https://apt.dockerproject.org/repo ubuntu-trusty main
Wily 15.10 | deb https://apt.dockerproject.org/repo ubuntu-wily main


docker-engine 安装前后对比
```
$ apt-cache policy docker-engine
docker-engine:
  已安装：  (无)
  候选软件包：1.12.5-0~ubuntu-trusty
  版本列表：
     1.12.5-0~ubuntu-trusty 0
        500 https://apt.dockerproject.org/repo/ ubuntu-trusty/main amd64 Packages
     1.12.4-0~ubuntu-trusty 0
        500 https://apt.dockerproject.org/repo/ ubuntu-trusty/main amd64 Packages
$ apt-cache policy docker-engine
docker-engine:
  已安装：  1.12.5-0~ubuntu-trusty
  候选软件包：1.12.5-0~ubuntu-trusty
  版本列表：
 *** 1.12.5-0~ubuntu-trusty 0
        500 https://apt.dockerproject.org/repo/ ubuntu-trusty/main amd64 Packages
        100 /var/lib/dpkg/status
```

Verify that docker is installed correctly by running the hello-world image.
```
$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c04b14da8d14: Pull complete 
Digest: sha256:0256e8a36e2070f7bf2d0b0763dbabdd67798512411de4cdcf9431a1feb60fd9
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```


创建私有仓库
https://docs.docker.com/registry/
```
$ sudo docker pull registry:2
$ sudo docker run -d -p 5000:5000 --name registry registry:2
```

测试私有仓库
```
$ sudo docker pull ubuntu:16.04
$ sudo docker tag ubuntu:16.04 127.0.0.1:5000/ubuntu:16.04
$ sudo docker push 127.0.0.1:5000/ubuntu:16.04
$ curl http://localhost:5000/v2/_catalog
{"repositories":["ubuntu"]}
```

TODO:删除私有仓库镜像
