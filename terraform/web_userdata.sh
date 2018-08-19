#!/bin/bash

yum -y install epel-release
yum -y install nginx ansible
systemctl enable nginx.service
systemctl start nginx.service
