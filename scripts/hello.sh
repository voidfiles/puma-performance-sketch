#!/bin/bash

# Mostly a copy of the puma hello benchmark
# https://github.com/puma/puma/blob/master/benchmarks/wrk/hello.sh
cd app;
PUMA_THREADS="${PUMA_THREADS:-4}"
WRK_CONCURRENT="${WRK_CONCURRENT:-4}"

bundle exec puma -t ${PUMA_THREADS} hello.ru &
PID1=$!
sleep 5
wrk -c ${WRK_CONCURRENT} -d 30 --latency http://localhost:9292

# echo "GET http://localhost:9292" | vegeta -cpus=2 attack -rate=100/1s -max-workers=100000 -duration=30s -timeout=1s | tee results.bin | vegeta report
# vegeta report -type=json results.bin > metrics.json
# cat results.bin | vegeta plot > plot.html
# cat results.bin | vegeta report -type="hist[0,100ms,200ms,300ms]"

kill $PID1