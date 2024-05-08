# Gitlab

```
docker pull gitlab/gitlab-ce:16.8.2-ce.0
```

```
GITLAB_HOME=$PWD

sudo docker run --detach \
  --hostname gitlab.example.com \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.example.com'; gitlab_rails['lfs_enabled'] = true;" \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  gitlab/gitlab-ce:16.8.2-ce.0
```


登录名称：`root`  
登录密码：`docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password`

将外部仓库拷贝至容器内部
```
docker cp <project>.git gitlab:/var/opt/gitlab/git-data/repositories/<user_dir>/
```

docker exec -it gitlab gitlab-rake gitlab:import:repos

重启实例，未看到加载的项目
