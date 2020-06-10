#!/bin/bash
set -e

# poor mans cron
while true; do
    sleep 55m

    echo '*** checking if we need to run reindex ***'

    hour=$(date +"%H")

    if [ "${hour}" = "03" ]; then
        echo '*** executing reindex ***'

        # delete all documents
        curl -X POST -H 'Content-Type: application/json' --data-binary '{"delete":{"query":"*:*" }}' http://localhost:8983/solr/multimedia-categories/update/?commit=true

        # kick off re-index
        curl http://localhost:8983/solr/multimedia-categories/dataimport?command=full-import
    fi
done
