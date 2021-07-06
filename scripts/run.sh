#!/bin/bash
PUMA_THREADS="${PUMA_THREADS:-4}"

function slowcat(){ while read; do sleep .05; echo "$REPLY"; done; }

PYTHONUNBUFFERED=x /usr/share/bcc/tools/tcplife -L 9292 -s |  awk -F',' '{print "hello.tcp.connection.latency:"int($10)"|ms"}' | slowcat | nc -w 1 -u localhost 8125 &
PID1=$!

cd app

bundle exec puma -t ${PUMA_THREADS} hello.ru & 
PID2=$!

function finish {
    kill $PID1
    kill $PID2
}

trap finish EXIT

while kill -s 0 $PID2; do
    ss -plnt -H sport = :9292 | awk '{print "hello.accept.queue:"$2"|g"}' | nc -w 1 -u localhost 8125
done

