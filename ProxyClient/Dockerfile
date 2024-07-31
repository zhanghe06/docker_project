FROM python:2.7.18

#apt-get install python-pip
#pip install git+https://github.com/shadowsocks/shadowsocks.git@master
WORKDIR /app

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y systemd python-pip privoxy

#COPY . .
COPY ./kcptun-linux-amd64-20230214.tar.gz ./kcptun-linux-amd64-20230214.tar.gz
COPY ./shadowsocks-2.9.1.tar.gz ./shadowsocks-2.9.1.tar.gz
COPY ./etc/kcptun.json /etc/kcptun.json
COPY ./etc/shadowsocks.json /etc/shadowsocks.json
COPY ./system/kcp-client.service /etc/systemd/system/kcp-client.service
COPY ./privoxy/config /etc/privoxy/config


RUN mkdir -p ~/.pip

RUN <<EOF > ~/.pip/pip.conf
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF


RUN pip install shadowsocks-2.9.1.tar.gz

RUN tar zxvf kcptun-linux-amd64-20230214.tar.gz && mv client_linux_amd64 /usr/bin/

EXPOSE 8118

CMD ["sslocal", "-c", "/etc/shadowsocks.json"]
