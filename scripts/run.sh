#!/bin/bash

rm -fR ../puma.pd ../stat.pid

PUMA_THREADS="${PUMA_THREADS:-4}"

function slownc(){ while read x; do echo "$x" | nc -w 1 -u localhost 8125; done; }

PYTHONUNBUFFERED=x /usr/share/bcc/tools/tcplife -L 9292 -s |  awk -F',' '{print "hello.tcp.connection.latency:"int($10)"|ms"}' | slownc &
PID1=$!

cd app

bundle exec puma -t ${PUMA_THREADS} hello.ru & 
PID2=$!

function finish {
    kill $PID1
    kill $PID2
}

echo $PID1 > ../puma.pid
echo $PID2 > ../stat.pid

trap finish EXIT

while kill -s 0 $PID2; do
    ss -plnt -H sport = :9292 | awk '{print "hello.accept.queue:"$2"|g"}' | nc -w 1 -u localhost 8125
done

