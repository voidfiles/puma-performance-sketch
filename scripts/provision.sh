#!/bin/bash

apt-get install ruby ruby-bundler golang netdata nginx

cp resources/.htpasswd /etc/nginx/.htpasswd
cp resource/nginx.conf /etc/nginx/sites-enabled/default

nginx restart