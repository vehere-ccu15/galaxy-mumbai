#!/bin/bash

curl -XGET 'http://192.168.30.30:9200/_cluster/health?pretty=true'
curl -XGET 'http://192.168.30.30:9200/_cat/indices?v&pretty=true&s=index'
