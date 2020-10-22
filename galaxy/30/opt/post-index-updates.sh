#!/bin/bash

previous_date="$(date --date="yesterday" +'%Y%m%d')"

current_date="$(date +'%Y%m%d')"

echo $previous_date
echo $current_date

index_name="logvehere-probe-"$previous_date
#current_index_name="logvehere-probe-"$current_date

echo $(date)

curl -XPOST "localhost:9200/$index_name/_forcemerge?max_num_segments=10"

#echo $(date)

curl -XPUT "localhost:9200/$index_name/_settings" -d'{"index":{"number_of_replicas":1}}'

#echo $(date)

#curl -XPUT localhost:9200/$current_index_name/_settings -d'{"index":{"max_result_window":100000}}'
