#!/bin/bash

apt-get update
apt-get upgrade
apt-get install -y git build-essential

mkdir -p $HOME/projects

cd $HOME/projects

git clone https://github.com/voidfiles/puma-performance-sketch.git

cd $HOME/projects/puma-performance-sketch

make provision