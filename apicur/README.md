# apicur

[https://www.apicur.io](https://www.apicur.io)

[https://github.com/Apicurio](https://github.com/Apicurio)

[getting-started-using-docker](https://www.apicur.io/studio/docs/getting-started-using-docker)

[apicurio-studio docker-compose](https://github.com/Apicurio/apicurio-studio/tree/master/distro/docker-compose)

```
docker run -v $(pwd):/apicurio chriske/apicurio-setup-image:latest bash /apicurio/setup.sh 192.168.65.84 mysql

OR

docker run -v ${PWD}:/apicurio chriske/apicurio-setup-image:latest /bin/bash -c "cp /apicurio/setup.sh /tmp/apicurio-setup.sh ; dos2unix /tmp/apicurio-setup.sh ; bash /tmp/apicurio-setup.sh 192.168.1.231 mysql"
```


```
Keycloak username: admin
Keycloak password: 9f1V-n

Keycloak URL: 192.168.65.84:8090
Apicurio URL: 192.168.65.84:8093
Microcks URL: 192.168.65.84:8900
```

```
cat .env
# 前台启动
./start-mysql-environment.sh
# 后台启动
docker-compose -f docker-compose.keycloak.yml -f docker-compose.microcks.yml -f docker-compose.apicurio.yml -f docker-compose-as-mysql.yml up -d
# 关闭服务
docker-compose -f docker-compose.keycloak.yml -f docker-compose.microcks.yml -f docker-compose.apicurio.yml -f docker-compose-as-mysql.yml down
```
