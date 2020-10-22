#!/bin/bash

curl -XGET "http://localhost:9200/_cat/tasks?v&s=node&detailed"

#curl -XGET 'localhost:9200/_tasks?actions=*search&detailed'
