#!/bin/bash
# -- Take snapshots
# -- A backup script you can run on cron would be as simple as this:
# SNAPSHOT=`date +%Y%m%d-%H%M%S`
# curl -XPUT "localhost:9200/_snapshot/my_backup/$SNAPSHOT?wait_for_completion=true"
# -- While it.s very easy to set up this backup, there is currently no logrotate included to remove old snapshots.
# -- I wrote a small script using the jq program that keeps the last 30 snapshots and deletes anything older:

#!/bin/bash
#
# Clean up script for old elasticsearch snapshots.
# 23/2/2014 karel@narfum.eu
#
# You need the jq binary:
# - yum install jq
# - apt-get install jq
# - or download from http://stedolan.github.io/jq/
# The amount of snapshots we want to keep.
LIMIT=1
LOGFILE=/var/log/snapshot_backup_withvariable.log;export LOGFILE

SNAPSHOT=`date +%Y%m%d-%H%M%S`
#TODAY=`date +%Y%m%d`
TODAY=$(date --date="1 day ago" +"%Y%m%d")
YESTERDAY=$(date --date="2 day ago" +"%Y%m%d")
TODAYSNAPSHOT=logvehere-probe-$TODAY
YESTERDAYSNAPSHOT=logvehere-probe-$YESTERDAY
echo $TODAYSNAPSHOT
echo $YESTERDAYSNAPSHOT
# curl -XPUT "localhost:9200/_snapshot/my_backup/$SNAPSHOT?wait_for_completion=true"
REPO=my_backup

 SNAPSHOTS=`curl -s -XGET "localhost:9200/_snapshot/$REPO/_all"`

# Loop over the results and delete each snapshot
# for SNAPSHOT in $SNAPSHOTS
# do
   echo "Deleting snapshot: $SNAPSHOTS" >> ${LOGFILE}
 curl -s -XDELETE "localhost:9200/_snapshot/$REPO/$SNAPSHOTS?pretty"
# done
 echo "Done!"


generate_post_data()
{
  cat <<EOF
{
 "indices": "$TODAYSNAPSHOT,$YESTERDAYSNAPSHOT,.kibana",
  "ignore_unavailable": true,
  "include_global_state": false

}
EOF
}

curl -XPUT "http://192.168.10.32:9200/_snapshot/my_backup/$SNAPSHOT?wait_for_completion=true" -H 'Content-Type: application/json' -d"$(generate_post_data)" > ${LOGFILE}

# Name of our snapshot repository
#REPO=my_backup

 SNAPSHOTSS=`curl -s -XGET "localhost:9200/_snapshot/$REPO/_all" \
  | jq -r ".snapshots[:-${LIMIT}][].snapshot"`

# Loop over the results and delete each snapshot
 for SNAPSHOT in $SNAPSHOTSS
 do
   echo "Deleting snapshot: $SNAPSHOT" >> ${LOGFILE}
 curl -s -XDELETE "localhost:9200/_snapshot/$REPO/$SNAPSHOT?pretty"
 done
 echo "Done!"


# Get a list of snapshots that we want to delete
# snapshot backup status
curl -XGET 'localhost:9200/_snapshot/my_backup/_all?pretty' >> ${LOGFILE}

