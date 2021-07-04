#!/bin/bash

apt-get install -y ruby ruby-bundler golang netdata nginx

cp resources/.htpasswd /etc/nginx/.htpasswd
cp resources/nginx.conf /etc/nginx/sites-enabled/default

systemctl restart nginx