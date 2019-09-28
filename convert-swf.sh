#!/bin/bash

FILENAME=$1
cd /data
OWNER=`ls -ld ${FILENAME} | awk '{print $3}'`
/swf_to_mp4.sh $FILENAME
chown $OWNER ${FILENAME%.*}.mp4
