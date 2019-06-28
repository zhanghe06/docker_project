## Kubernetes

https://github.com/kubernetes/kubernetes

https://kubernetes.io/zh/docs/tutorials/kubernetes-basics/

docker for mac edge版 配置

1、首先是切换到edge版

2、然后是设置代理

Manual proxy configuration
```
http://127.0.0.1:1087
```

- Docker Desktop is running
- Kubernetes is running


Kubernetes 所依赖的镜像
```
➜  ~ docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
k8s.gcr.io/kube-proxy                v1.13.0             8fa56d18961f        7 weeks ago         80.2MB
k8s.gcr.io/kube-controller-manager   v1.13.0             d82530ead066        7 weeks ago         146MB
k8s.gcr.io/kube-scheduler            v1.13.0             9508b7d8008d        7 weeks ago         79.6MB
k8s.gcr.io/kube-apiserver            v1.13.0             f1ff9b7e3d6e        7 weeks ago         181MB
docker/kube-compose-controller       v0.4.15             f88402c8712a        8 weeks ago         29.6MB
docker/kube-compose-api-server       v0.4.15             55c26034b2e7        8 weeks ago         46.9MB
k8s.gcr.io/coredns                   1.2.6               f59dcacceff4        2 months ago        40MB
k8s.gcr.io/etcd                      3.2.24              3cab8e1b9802        4 months ago        220MB
k8s.gcr.io/pause                     3.1                 da86e6ba6ca1        13 months ago       742kB
```

创建 k8s dashboard

[Kubernetes Dashboard](https://github.com/kubernetes/dashboard)

```
➜  ~ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

secret/kubernetes-dashboard-certs created
serviceaccount/kubernetes-dashboard created
role.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
deployment.apps/kubernetes-dashboard created
service/kubernetes-dashboard created
```

开启代理（允许本地访问Dashboard）
```
➜  ~ kubectl proxy
Starting to serve on 127.0.0.1:8001
```

等待片刻，访问[K8S Dashboard UI](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)

```bash
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default


查看集群信息
```bash
kubectl cluster-info
```

获取集群状态
```bash
kubectl get cs
```

查看版本
```bash
kubectl version
```

获取受支持资源的完整列表
```bash
kubectl api-resources
```

常用获取操作
```bash
kubectl get deployments
kubectl get endpoints
kubectl get services
kubectl get nodes
kubectl get pods
kubectl get configmaps
kubectl get namespaces
kubectl get daemonsets
kubectl get ingresses
kubectl get customresourcedefinitions
```

对应缩写
```bash
kubectl get deploy
kubectl get ep
kubectl get svc
kubectl get no
kubectl get po
kubectl get cm
kubectl get ns
kubectl get ds
kubectl get ing
kubectl get crd
```

指定命名空间（全部或单个）
```
--all-namespaces
-n [namespace]
```

输出节点信息
```
-o wide
```

pod是kubernetes调度和管理的最小单位

### 文档

master节点（3个进程）

- kube-apiserver
- kube-controller-manager
- kube-scheduler

非master节点（2个进程）

- kubelet
- kube-proxy


Kubernetes 对象

- Pod
- Service
- Volume
- Namespace

控制器（controllers）

- ReplicaSet
- Deployment
- StatefulSet
- DaemonSet
- Job


### 基本概念

- Cluster 集群 计算，存储和网络资源的集合，k8s利用这些资源运行应用
- Master 用于调度与管理整合系统的主机，为了保证高可用，可以包含多个master节点
- Node 用于运行容器应用的主机，根据Master的要求管理容器的生命周期
- Pod 最小的调度单元，内部可以包含一个或多个container，pod内容的containter共享资源，一般情况下采用one-container-per-pod模型
- Controller kubernetes一般使用controller来管理pod，controller中可能包含多个副本的pod，最常用的就是Deployment
- Service 每个Pod有自己的IP，而且可能动态变化，为了能正确访问，service提供一种访问pod的方式，为pod提供负载均衡。具体访问方式：service有自己固定的IP地址，service利用label选择特定的一组pod，kubernetes会维护service和pod之间的映射关系，需要访问pod时，只需访问service即可。
- label 使用键值对去选择特定的一组pod。可以使用label标记特定的一组pod，然后使用selector进行选择


### 基本组件

- Pod：K8s 的基本运行单元；
- ReplicaSet：Pod 的集合；
- Deployment：提供更新支持；
- StatefulSets：提供有状态支持；
- Volume：数据卷；
- Labels：标签，资源间的关联一般通过这个来实现。


### 服务类型

- 无状态服务
- 普通有状态服务
- 有状态集群服务


### 持久化方式

- 普通 Volume
- Persistent Volume
    - 静态（手动创建）
    - 动态（通过Storage Class对象由存储系统根据PVC的要求自动创建）


### 存储方式

- emptyDIR 临时目录（pod删除了，emptyDir也随之删除）
- hostPath 使用主机的路径
- 网络存储（nfs）
    - 传统的设备存储: NAS, SAN
    - 分布式存储: glusterfs, rbd, cephfs
    - 云存储: EBS, Azure, 阿里云

```
管理员关注于如何通过pv提供存储功能而无需关注用户如何使用
用户只需要挂载pvc到容器中而不需要关注存储卷采用何种技术实现

pv和pvc是一对一绑定的。但是多个pod可以挂载同一个pvc
通常使用的流程是，首先创建存储，在创建pv，接着创建pvc，pod挂载到相应的pvc
```


### pv和pvc的生命周期

- 供应准备（Provisioning）
    - 静态提供（static）: 管理员手动创建多个PV, 供PVC使用
    - 动态提供（dynamic）: 动态创建PVC特定的PV, 并绑定
- 绑定
- 使用
- 释放
- 回收（Reclaiming）
    - 保留（Retain）
    - 回收（Recycle）
    - 删除（Delete）

PV卷阶段状态
```
Available – 资源尚未被claim使用
Bound – 卷已经被绑定到claim了
Released – claim被删除，卷处于释放状态，但未被集群回收。
Failed – 卷自动回收失败
```


### 组件进化

- Replication Controller（RC）: 用来部署、升级Pod
- Replication Set（RS）: 下一代的Replication Controller
- Deployment: 可以更加方便的管理Pod和Replica Set

在一般情况下，我们推荐使用Deployment而不直接使用Replica Set



### Kubernetes系统中的三种IP

- Node IP：Node节点的IP地址
- Pod IP: Pod的IP地址
- Cluster IP: Service的IP地址


### Kubernetes的三种外部访问方式
- NodePort
- LoadBalancer
- Ingress（转发）

ClusterIP 服务是 Kubernetes 的默认服务。它给你一个集群内的服务，集群内的其它应用都可以访问该服务。集群外部无法访问它。
得使用 Kubernetes 的 proxy 模式来访问你的服务
这种方式要求我们运行 kubectl 作为一个未认证的用户，因此我们不能用这种方式把服务暴露到 internet 或者在生产环境使用。

NodePort 服务是引导外部流量到你的服务的最原始方式。
NodePort 服务主要有两点区别于普通的“ClusterIP”服务。
第一，它的类型是“NodePort”。
有一个额外的端口，称为 nodePort
每个端口只能是一种服务
端口范围只能是 30000-32767
如果节点/VM 的 IP 地址发生变化，你需要能处理这种情况
不建议在生产环境上用这种方式暴露服务。

LoadBalancer 服务是暴露服务到 internet 的标准方式。
这个方式的最大缺点是每一个用 LoadBalancer 暴露的服务都会有它自己的 IP 地址，每个用到的 LoadBalancer 都需要付费，这将是非常昂贵的。

Ingress 可能是暴露服务的最强大方式，但同时也是最复杂的。
有别于以上所有例子，Ingress 事实上不是一种服务类型。
相反，它处于多个服务的前端，扮演着“智能路由”或者集群入口的角色。
Ingress 控制器有各种类型，包括 Google Cloud Load Balancer， Nginx，Contour，Istio，等等。
它还有各种插件，比如 cert-manager，它可以为你的服务自动提供 SSL 证书。


https://kubernetes.github.io/ingress-nginx/deploy/#docker-for-mac
