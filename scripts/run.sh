#!/bin/bash
PUMA_THREADS="${PUMA_THREADS:-4}"

/usr/share/bcc/tools/tcplife -L 9292 | awk '{print "hello.tcp.connection.latency:"$9"|ms"}' | nc -w 1 -u localhost 8125 &
PID1=$!

(cd app && bundle exec puma -t ${PUMA_THREADS} hello.ru)

kill $PID1