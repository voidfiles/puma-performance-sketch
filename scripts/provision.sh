#!/bin/bash
apt-get install -y ruby-dev ruby ruby-bundler golang nginx wrk

cp resources/.htpasswd /etc/nginx/.htpasswd
cp resources/nginx.conf /etc/nginx/sites-enabled/default

systemctl restart nginx
systemctl restart datadog-agent 