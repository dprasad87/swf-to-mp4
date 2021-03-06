#!/bin/bash

SWFFILE=$1
MP4FILE=${SWFFILE%.*}.mp4
TMPFILE=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 32 | head -n 1).bin
TMPWAV=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 32 | head -n 1).wav
TMPMP4=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 32 | head -n 1).mp4
echo 'Output file name: ' $MP4FILE

# creating raw-dump
echo '......creating raw-dump'
GNASHCMD="dump-gnash -1 -r 3 -v -D $TMPFILE -A $TMPWAV $SWFFILE"
OUTPUT="$(exec $GNASHCMD)"


# extract parameters
WIDTH="$(echo $OUTPUT | grep -o 'WIDTH=[^, }]*' | sed 's/^.*=//')"
HEIGHT="$(echo $OUTPUT | grep -o 'HEIGHT=[^, }]*' | sed 's/^.*=//')"
FPS="$(echo $OUTPUT | grep -o 'FPS_ACTUAL=[^, }]*' | sed 's/^.*=//')"
echo 'Video width :' $WIDTH
echo 'Video height :' $HEIGHT

# create raw, uncompressed mp4 file
echo ".....creating raw, uncompressed ${MP4FILE} file"
mplayer $TMPFILE -vo yuv4mpeg:file=$TMPMP4 -demuxer rawvideo -rawvideo fps=$FPS:w=$WIDTH:h=$HEIGHT:format=bgra

# create compressed mp4 with ffmpeg
echo "......creating compressed mp4 with ffmpeg"
ffmpeg -i $TMPMP4 -i $TMPWAV -strict -2 $MP4FILE

# clean up
echo "cleaning up"
rm -rf $TMPFILE
rm -rf $TMPMP4
rm -rf $TMPWAV
