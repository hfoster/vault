#!/bin/bash

APP_DL_LINK=https://releases.hashicorp.com/${app_name}/${app_version}/${app_name}_${app_version}_linux_amd64.zip

yum -y install epel-release
yum -y install wget unzip nginx
wget $APP_DL_LINK -O /usr/bin/${app_name}.zip
unzip /usr/bin/${app_name}.zip -d /usr/bin/
rm /usr/bin/${app_name}.zip
export VAULT_ADDR='http://127.0.0.1:8200'
vault server -dev -dev-root-token-id="root"

cat << EOF> /etc/nginx/conf.d/vault.conf
location / {
proxy_pass http://127.0.0.1:8200/;
proxy_set_header X-Real-IP $remote_addr;
}
EOF
systemctl enable nginx.service
systemctl restart nginx.service
