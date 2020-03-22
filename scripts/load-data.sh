#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

elasticsearch_loader --index books json es/books.json

# file has to be prepared for bulk mode to do this
# curl  -XPOST 'localhost:9200/financial/accounts/_bulk?pretty' --data-binary @es/books.json -H 'Content-Type: application/x-ndjson'
