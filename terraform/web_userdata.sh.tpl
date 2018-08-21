#!/bin/bash

yum -y install epel-release
yum -y install nginx
cat << EOF > /etc/nginx/conf.d/vault.conf
location / {
  proxy_pass http://${internal_url}:8200/;
  proxy_set_header X-Real-IP $remote_addr;
}
EOF
systemctl enable nginx.service
systemctl restart nginx.service
