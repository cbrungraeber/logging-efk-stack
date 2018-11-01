#!/bin/bash
./wait-for-it.sh $ELASTICSEARCH

sleep 30

# Remove possibly existing index
echo "Removing possible existing index..."
curl -XDELETE http://$ELASTICSEARCH/.kibana

# Create index
# https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html
# https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-mapping.html
echo "Creating index..."
curl -XPUT -H "Content-Type: application/json" http://$ELASTICSEARCH/.kibana --data-binary "@./data/kibana.json"

# Bulk insert docs
# https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html
echo "Inserting documents..."
curl -XPOST -H "Content-Type: application/x-ndjson" http://$ELASTICSEARCH/_bulk --data-binary "@./data/docs_interleaved.json"
