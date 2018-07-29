#!/bin/bash

APP_DL_LINK=https://releases.hashicorp.com/${app_name}/${app_version}/${app_name}_${app_version}_linux_amd64.zip

wget $APP_DL_LINK -O /tmp/${app_name}.zip
unzip /tmp/${app_name}.zip
mv /tmp/${app_name} /usr/bin/${app_name}
export PATH=/usr/bin/:$PATH
