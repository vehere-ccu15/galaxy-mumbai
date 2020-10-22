#!/bin/bash

curl -XPOST "http://192.168.30.30:9200/_snapshot/my_backup/20201016-124416/_restore?wait_for_completion=true" -H 'Content-Type: application/json' -d'
{
  "indices": "logvehere-monitor-20201014",
  "ignore_unavailable": true,
  "include_global_state": true
}'


echo "Done!"


