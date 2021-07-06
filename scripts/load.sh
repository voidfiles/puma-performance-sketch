#!/bin/bash
VIRTUAL_USERS=${VIRTUAL_USERS:-2}
DURATION=${DURATION:-30s}

K6_STATSD_ENABLE_TAGS=true k6 run -u ${VIRTUAL_USERS} -d ${DURATION} --no-connection-reuse --out statsd scripts/script.js