#!/bin/bash

curl -XPOST "http://localhost:9200/_tasks/_cancel?actions=*search"


