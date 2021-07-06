#!/bin/bash
PUMA_THREADS="${PUMA_THREADS:-4}"

(cd app && bundle exec puma -t ${PUMA_THREADS} hello.ru)