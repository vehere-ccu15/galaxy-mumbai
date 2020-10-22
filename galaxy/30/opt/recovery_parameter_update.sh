#!/bin/bash

curl -XPUT "localhost:9200/_cluster/settings" -d'{"persistent":{"cluster.routing.allocation.node_concurrent_recoveries":20,"cluster.routing.allocation.node_initial_primaries_recoveries":60}}'

curl -XPUT "localhost:9200/_cluster/settings" -d'{"persistent":{"indices.recovery.max_bytes_per_sec":"250mb"}}'
