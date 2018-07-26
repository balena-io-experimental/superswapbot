#!/usr/bash

COMMAND=${COMMAND:=query}
INTERVAL=${INTERVAL:=60}

COUNT=0
while : ; do
    echo "run query #$((COUNT++))"
    for c in config/*.json; do
        env=$(basename "$c" .json)
        versions_file="versions/versions_${env}.json"
        if [ -f "${versions_file}" ]; then
            echo "Running '${COMMAND}' in env: ${env}"
            NODE_ENV="${env}" node index.js "${COMMAND}" -b "${versions_file}" -r
        fi
    done
    sleep "${INTERVAL}"
done
