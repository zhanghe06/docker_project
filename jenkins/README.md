## jenkins

https://jenkins.io/

https://jenkins.io/download/

官方镜像: https://hub.docker.com/r/jenkins/jenkins/

docker hub 镜像已弃用: https://hub.docker.com/_/jenkins/

官方 GitHub: https://github.com/jenkinsci/docker

```
docker pull jenkins/jenkins:lts
```

容器启动后查看初始化管理密码
```
cat jenkins_home/secrets/initialAdminPassword
```

访问: http://0.0.0.0:8080/

填入刚刚查看的密码即可

创建用户名密码:
```
admin
123456
```

选择安装推荐插件


## Blue Ocean

https://github.com/jenkinsci/blueocean-plugin

https://hub.docker.com/r/jenkinsci/blueocean/

```
docker pull jenkinsci/blueocean
```

http://0.0.0.0:8080/blue
