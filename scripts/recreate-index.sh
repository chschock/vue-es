#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

INDEX=books

curl -XDELETE "localhost:9200/$INDEX?pretty"

curl -XPUT "localhost:9200/$INDEX?pretty" -d @es/mapping.json --header "Content-Type: application/json"
