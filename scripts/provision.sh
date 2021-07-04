#!/bin/bash

apt-get install -y ruby-dev ruby ruby-bundler golang netdata nginx wrk

cp resources/.htpasswd /etc/nginx/.htpasswd
cp resources/nginx.conf /etc/nginx/sites-enabled/default
cp resources/dashboard.html /usr/share/netdata/web/

systemctl restart nginx