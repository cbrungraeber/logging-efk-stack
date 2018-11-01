#!/bin/bash

# Save kibana mapping
curl -XGET http://localhost:9200/.kibana | jq '.".kibana"' | jq 'del(.settings)' > ./data/kibana.json

# Save docs, index action
curl -XPOST http://localhost:9200/.kibana/_search -d '{ "from": 0, "size": 1000 }' -H 'Content-Type: application/json' -H 'Accept: application/json' | jq '.hits.hits[]' | jq 'del(._score)' | jq 'del(._source)' | jq -c '{index: .}' > ./data/docs_ids.json

# Save docs, contents
curl -XPOST http://localhost:9200/.kibana/_search -d '{ "from": 0, "size": 1000 }' -H 'Content-Type: application/json' -H 'Accept: application/json' | jq '.hits.hits[]' | jq -c '._source' > ./data/docs_sources.json

# Interleave files
# https://stackoverflow.com/a/4011824
paste -d '\n' ./data/docs_ids.json ./data/docs_sources.json > ./data/docs_interleaved.json
