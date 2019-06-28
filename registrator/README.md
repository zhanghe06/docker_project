## Registrator

https://github.com/gliderlabs/registrator

http://gliderlabs.github.io/registrator/latest/user/quickstart/

```
$ docker pull gliderlabs/registrator:latest
```

```
$ curl $(boot2docker ip):8500/v1/catalog/services
{"consul":[]}
```

Running Registrator
```
$ docker run -d \
    --name=registrator \
    --net=host \
    --volume=/var/run/docker.sock:/tmp/docker.sock \
    gliderlabs/registrator:latest \
      etcd://
```


```
$ docker logs registrator
2017/12/20 08:27:06 Starting registrator v7 ...
2017/12/20 08:27:06 Using etcd adapter: etcd://
2017/12/20 08:27:06 Connecting to backend (0/0)
2017/12/20 08:27:06 Listening for Docker events ...
2017/12/20 08:27:06 Syncing services on 5 containers
2017/12/20 08:27:06 ignored: 357770ea2d21 no published ports
2017/12/20 08:27:06 added: d6c753ae36b8 moby:etcd:2379
2017/12/20 08:27:06 added: d6c753ae36b8 moby:etcd:2380
2017/12/20 08:27:06 added: 8a5fd1ea6ca7 moby:redis:6379
2017/12/20 08:27:06 added: 08e4308063ae moby:memcached:11211
2017/12/20 08:27:06 added: 8e333f2e8ca6 moby:mariadb:3306
```

```
$ docker stop redis
```

```
$ docker logs registrator
2017/12/20 08:27:06 Starting registrator v7 ...
2017/12/20 08:27:06 Using etcd adapter: etcd://
2017/12/20 08:27:06 Connecting to backend (0/0)
2017/12/20 08:27:06 Listening for Docker events ...
2017/12/20 08:27:06 Syncing services on 5 containers
2017/12/20 08:27:06 ignored: 357770ea2d21 no published ports
2017/12/20 08:27:06 added: d6c753ae36b8 moby:etcd:2379
2017/12/20 08:27:06 added: d6c753ae36b8 moby:etcd:2380
2017/12/20 08:27:06 added: 8a5fd1ea6ca7 moby:redis:6379
2017/12/20 08:27:06 added: 08e4308063ae moby:memcached:11211
2017/12/20 08:27:06 added: 8e333f2e8ca6 moby:mariadb:3306
2017/12/20 08:33:34 removed: 8a5fd1ea6ca7 moby:redis:6379
```
