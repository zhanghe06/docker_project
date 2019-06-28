#!/usr/bin/env bash


SYSTEM_PLATFORM="`uname`"
CONFD_VER="0.14.0"
FILE_NAME="confd-${CONFD_VER}-${SYSTEM_PLATFORM}-amd64"

if [ ! -f "confd" ]; then
    wget -c https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/${FILE_NAME} -O confd
    chmod +x confd
fi

CONF_DIR="etc/confd"
ETCD_NODE="http://127.0.0.1:2379"

[ -d ${CONF_DIR} ] || mkdir -p ${CONF_DIR}/{conf.d,templates}

./confd -confdir ${CONF_DIR} -backend etcd -node ${ETCD_NODE} -watch
