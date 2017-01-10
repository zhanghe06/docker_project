
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
