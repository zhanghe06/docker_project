# OpenVPN

https://openvpn.net

https://github.com/kylemanna/docker-openvpn

https://hub.docker.com/r/kylemanna/openvpn

https://openvpn.net/access-server/

https://hub.docker.com/r/openvpn/openvpn-as

```
docker run -d \
  --name=openvpn-as \
  --cap-add=NET_ADMIN \
  --restart unless-stopped \
  -e TZ=Asia/Shanghai \
  -p 943:943 \
  -p 443:443 \
  -p 1194:1194/udp \
  -v $PWD/config:/openvpn \
  openvpn/openvpn-as
```

Admin UI: https://localhost:943/admin
Client UI: https://localhost:943

默认管理账号
```
openvpn
```

查看管理密码
```
docker exec -it openvpn-as cat /usr/local/openvpn_as/init.log
docker exec -it openvpn-as grep -i 'password.$' /usr/local/openvpn_as/init.log
```

初始密码无法登录，需要重置

重置管理密码

https://openvpn.net/vpn-server-resources/troubleshooting-authentication-related-problems/

```
cd /usr/local/openvpn_as/scripts
./sacli --user "openvpn" --key "prop_superuser" --value "true" UserPropPut
./sacli --user "openvpn" --key "user_auth_type" --value "local" UserPropPut
./sacli --user "openvpn" --new_pass=<PASSWORD> SetLocalPassword
./sacli start
```

破解人数限制

```
docker exec -it openvpn-as bash
```

```
apt install zip
apt install unzip
cd /usr/local/openvpn_as/lib/python
mkdir unlock_license && mv pyovpn-2.0-py3.10.egg pyovpn-2.0-py3.10.egg_bak
cp -rp pyovpn-2.0-py3.10.egg_bak unlock_license/pyovpn-2.0-py3.10.zip
cd unlock_license && unzip pyovpn-2.0-py3.10.zip
cd pyovpn/lic/ && mv uprop.pyc uprop2.pyc
cat > uprop.py << EOF
from pyovpn.lic import uprop2
old_figure = None

def new_figure(self, licdict):
    ret = old_figure(self, licdict)
    ret['concurrent_connections'] = 1024
    return ret


for x in dir(uprop2):
    if x[:2] == '__':
        continue
    if x == 'UsageProperties':
        exec('old_figure = uprop2.UsageProperties.figure')
        exec('uprop2.UsageProperties.figure = new_figure')
    exec('%s = uprop2.%s' % (x, x))
EOF
python3 -O -m compileall uprop.py
cd /usr/local/openvpn_as/lib/python/unlock_license && zip -r pyovpn-2.0-py3.10_cracked.zip common EGG-INFO pyovpn
mv /usr/local/openvpn_as/lib/python/unlock_license/pyovpn-2.0-py3.10_cracked.zip /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.10.egg
```

```
docker restart openvpn-as
```
