### 系统配置

说明: 以下配置基于 centos 7.3 虚拟机

1、关闭 SELINUX
```bash
vi /etc/selinux/config
```
SELINUX=enforcing
改为:
SELINUX=permissive


2、关闭 DNS 反向解析
```bash
vi /etc/ssh/sshd_config
```
设置 UseDNS no
```bash
systemctl restart sshd
```

3、关闭防火墙
```bash
systemctl stop firewalld
systemctl disable firewalld
systemctl stop iptables
systemctl disable iptables
```

4、配置双网卡（两个桥接）
```
ens33:
    inet 10.21.2.29  netmask 255.255.255.0  broadcast 10.21.2.255
ens37:
    inet 10.21.2.84  netmask 255.255.255.0  broadcast 10.21.2.255
```


也可能是
```
ens33:
    inet 192.168.3.47  netmask 255.255.255.0  broadcast 192.168.3.255
ens37:
    inet 192.168.3.48  netmask 255.255.255.0  broadcast 192.168.3.255
```



```bash
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all
yum makecache
```

### Docker 安装

https://docs.docker.com/engine/installation/linux/docker-ce/centos/


```bash
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl status docker
systemctl enable docker
systemctl start docker
```

配置 docker 加速（可选）
```bash
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://12248bc3.m.daocloud.io
cat /etc/docker/daemon.json
systemctl restart docker
```

配置私有存储库
```bash
docker run \
    -h registry \
    --name registry \
    -v ${PWD}/registry:/var/lib/registry \
    -p 4000:5000 \
    --restart always \
    -d \
    registry:2
```


Create the drop-in unit directory for docker.service
```bash
mkdir -p /etc/systemd/system/docker.service.d
```

Create the drop-in unit file
```bash
tee /etc/systemd/system/docker.service.d/kolla.conf <<-'EOF'
[Service]
MountFlags=shared
EOF
```

```bash
systemctl daemon-reload
systemctl restart docker
```


Kolla 和 Kolla-Ansible 安装

https://docs.openstack.org/kolla-ansible/latest/user/quickstart.html

```bash
yum install -y epel-release
yum install -y git wget vim-enhanced
yum install -y python-pip
yum install -y python-devel libffi-devel gcc openssl-devel libselinux-python
```

配置 pip 源加速（可选）
```bash
mkdir ~/.pip
tee ~/.pip/pip.conf <<-'EOF'
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF
```

```bash
pip install -U pip
pip install -U ansible
pip install -U docker
```

```bash
yum install -y ntp
systemctl enable ntpd
systemctl start ntpd
date
```

```bash
systemctl stop libvirtd
systemctl disable libvirtd
```

```bash
pip install kolla-ansible
cp -r /usr/share/kolla-ansible/etc_examples/kolla /etc/kolla/
cp /usr/share/kolla-ansible/ansible/inventory/* .
```

```bash
ip addr show | grep UP
```
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
3: ens37: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN
```

```bash
vi /etc/kolla/globals.yml
```

```
kolla_internal_vip_address: "192.168.3.50"
network_interface: "ens33"
neutron_external_interface: "ens37"
api_interface: "{{ network_interface }}"
```

如果是在虚拟机里安装 Kolla，希望可以在 OpenStack 平台上创建虚拟机，需要设置 virt_type=qemu，默认是KVM。
```bash
mkdir -p /etc/kolla/config/nova
cat << EOF > /etc/kolla/config/nova/nova-compute.conf
[libvirt]
virt_type = qemu
cpu_mode = none
EOF
```

如果部署的是单节点，需要编辑 /usr/share/kolla-ansible/ansible/group_vars/all.yml
```bash
vim /usr/share/kolla-ansible/ansible/group_vars/all.yml
```
```
enable_haproxy: "no"

network_interface: "ens33"
neutron_external_interface: "ens37"

nova_compute_virt_type: "qemu"
```

```bash
vim /etc/kolla/globals.yml
```
```
#docker_registry: "192.168.3.47:4000"
#docker_namespace: "companyname"
#docker_registry_username: "sam"
#docker_registry_password: "correcthorsebatterystaple"
```

添加 hosts 配置
（解决报错: Hostname has to resolve to IP address of api_interface）
```bash
vim /etc/hosts
```

```bash
127.0.0.1   localhost
::1         localhost
192.168.3.47    localhost
```


```bash
kolla-genpwd                                    # 生成密码
vim /etc/kolla/passwords.yml                    # 修改密码
kolla-ansible prechecks -i ${PWD}/all-in-one    # 预检配置

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

pip install -U tox
cd kolla/
tox -e genconfig
cp -rv etc/kolla /etc/

kolla-build
kolla-build --registry 192.168.3.47:5000 --push
kolla-ansible deploy -i ${PWD}/all-in-one
```
