#!/bin/bash
K6_STATSD_ENABLE_TAGS=true k6 run -u 2 -d 30s --no-connection-reuse --out statsd scripts/script.js