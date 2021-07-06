#!/bin/bash
PUMA_THREADS="${PUMA_THREADS:-4}"

/usr/share/bcc/tools/tcplife -L 9292 | awk '{print "hello.tcp.connection.latency:"$9"|ms"}' | nc -w 1 -u localhost 8125 &
PID1=$!

cd app

bundle exec puma -t ${PUMA_THREADS} hello.ru & 
PID2=$!

func finish {
    kill $PID1
    kill $PID2
}

trap finish EXIT

while kill -s 0 $PID2; do
    ss -plnt -H sport = :9292 | awk '{print "hello.accept.queue:"$2"|g"}' | nc -w 1 -u localhost 8125
done

