## registry

https://hub.docker.com/_/registry/


例子
```bash
$ docker run -d -p 5000:5000 --restart always --name registry registry:2

$ docker pull ubuntu
$ docker tag ubuntu localhost:5000/ubuntu
$ docker push localhost:5000/ubuntu
```
