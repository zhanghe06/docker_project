cAdvisor

https://hub.docker.com/r/google/cadvisor/
```
$ docker pull google/cadvisor
```

https://github.com/google/cadvisor


目录(/sys; /var/lib/docker)挂载 mac 下不支持

可能有些机器上会出现`/sys/fs/cgroup/cpuacct,cpu: no such file or directory`报错
```
# mount -o remount,rw /sys/fs/cgroup/
# ln -sf /sys/fs/cgroup/cpu,cpuacct /sys/fs/cgroup/cpuacct,cpu
```
