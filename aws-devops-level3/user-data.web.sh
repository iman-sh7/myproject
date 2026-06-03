#!/bin/bash

yum -y update && yum -y upgrade

yum install nginx -y
service nginx start

yum -y install git-core

rm -rf hello-me
git clone https://github.com/nenemustafa/Hellome.git

rm -f /usr/share/nginx/html/*.html
cp hello-me/html/* /usr/share/nginx/html/
