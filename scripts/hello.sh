#!/bin/bash

# Mostly a copy of the puma hello benchmark
# https://github.com/puma/puma/blob/master/benchmarks/wrk/hello.sh
cd app;

PUMA_THREADS="${PUMA_THREADS:-4}"
WRK_CONCURRENT="${WRK_CONCURRENT:-4}"
DURATION="${DURATION:-30}"

bundle exec puma -t ${PUMA_THREADS} hello.ru &
PID1=$!

sleep 10

wrk -c ${WRK_CONCURRENT} -d ${DURATION} --latency http://localhost:9292 &
PID2=$!

if command -v ss; then
    while kill -s 0 $PID2; do
        ss -plnt -H sport = :9292 | awk '{print "hello.accept.queue:"$2"|g"}' | nc -w 1 -u localhost 8125
    done
else
    wait $PID2
fi

kill $PID1
