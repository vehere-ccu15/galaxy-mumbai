#!/bin/bash

previous_date="$(date --date="yesterday" +'%Y%m%d')"

echo $previous_date

index_name="logvehere-probe-"$previous_date

echo $(date)

curl -XPOST "localhost:9200/$index_name/_forcemerge?max_num_segments=5"

#curl -XPUT localhost:9200/$current_index_name/_settings -d'{"index":{"max_result_window":100000}}'
