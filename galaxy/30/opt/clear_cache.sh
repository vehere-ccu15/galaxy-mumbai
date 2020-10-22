#!/bin/bash

curl -XPOST "http://localhost:9200/_cache/clear"

#curl -XPOST "http://localhost:9200/_cache/clear?field_data=true"
#curl -XPOST "http://localhost:9200/_cache/clear?query=true"
#curl -XPOST "http://localhost:9200/_cache/clear?request=true"

#current_date="$(date +'%Y%m%d')"
#echo $current_date
#index_name="logvehere-probe-"$current_date
#curl -XPOST "http://localhost:9200/$index_name/_flush"
