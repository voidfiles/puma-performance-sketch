#!/bin/bash

apt-get install git

mkdir -p $HOME/projects

cd $HOME/projects

git clone https://github.com/voidfiles/puma-performance-sketch.git

cd $HOME/puma-performance-sketch

make provision