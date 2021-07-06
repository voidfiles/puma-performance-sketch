#!/bin/bash
K6_STATSD_ENABLE_TAGS=true k6 run --out statsd script.js