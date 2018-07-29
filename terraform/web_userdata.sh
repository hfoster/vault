#!/bin/bash

yum -y install nginx
systemctl enable nginx.service
systemctl start nginx.service
