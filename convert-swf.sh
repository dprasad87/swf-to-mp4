#!/bin/bash

FILENAME=$1
cd /data
OWNER=`ls -ld ${FILENAME} | awk '{print $3}'`
echo "OWNER : "+ ${OWNER}
cp /data/swf_to_mp4.sh /
rm /data/swf_to_mp4.sh
chmod u+x /swf_to_mp4.sh
/swf_to_mp4.sh $FILENAME
chown $OWNER ${FILENAME%.*}.mp4
