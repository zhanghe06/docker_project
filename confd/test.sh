#!/usr/bin/env bash

CONF_DIR="etc/confd"
ETCD_NODE="http://127.0.0.1:2379"


curl -X PUT ${ETCD_NODE}/v2/keys/myapp/database/url -d value="db.example.com"
curl -X PUT ${ETCD_NODE}/v2/keys/myapp/database/user -d value="rob"

# Create a template resource config
tee etc/confd/conf.d/myconfig.toml <<-'EOF'
[template]
src = "myconfig.conf.tmpl"
dest = "/tmp/myconfig.conf"
keys = [
    "/myapp/database/url",
    "/myapp/database/user",
]
EOF


# Create the source template
tee etc/confd/templates/myconfig.conf.tmpl <<-'EOF'
[myconfig]
database_url = {{getv "/myapp/database/url"}}
database_user = {{getv "/myapp/database/user"}}
EOF


# Process the template (etcd)
./confd -confdir ${CONF_DIR} -onetime -backend etcd -node ${ETCD_NODE}


cat /tmp/myconfig.conf

curl -X PUT ${ETCD_NODE}/v2/keys/myapp/database/user -d value="tom"

cat /tmp/myconfig.conf
