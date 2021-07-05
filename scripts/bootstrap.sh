#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y git build-essential

mkdir -p $HOME/projects

cd $HOME/projects

git clone https://github.com/voidfiles/puma-performance-sketch.git

cd $HOME/projects/puma-performance-sketch

DD_AGENT_MAJOR_VERSION=7 DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

make provision