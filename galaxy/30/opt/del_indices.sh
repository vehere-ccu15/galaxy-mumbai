#!/bin/sh
# Execute from root user
# curator --config curator.yml --dry-run delete_indices.yml
export LOGFILE=/var/log/curator_del_indices.log

curator --config /usr/local/etc/curator.yml /usr/local/etc/delete_indices.yml > ${LOGFILE}
