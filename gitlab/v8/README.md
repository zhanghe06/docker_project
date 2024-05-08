# Gitlab

默认登录信息
```
用户：admin@example.com
密码：5iveL!fe
```

http://127.0.0.1/profile/password/new

修改密码：12345678


```
docker cp lifewow-android.git gitlab:/var/opt/gitlab/git-data/repositories/mobile/lifewow-android.git

# 关键步骤（因为上个步骤是从外部导入的仓库，需要变更为git所有者）
docker exec -it gitlab chown -R git:git /var/opt/gitlab/git-data/repositories

docker exec -it gitlab gitlab-rake gitlab:import:repos
```

进入管理界面查找项目：[http://127.0.0.1/admin](http://127.0.0.1/admin)
