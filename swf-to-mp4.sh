#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: convert.sh input.swf"
    echo "will produce input.mp4 as output"
    exit 1
fi

PASSED=$1

if [ -d "${PASSED}" ]; then
    echo "Directory ${PASSED} was passed."
    for swfile in ${PASSED}/*.swf
        do
        echo "Converting $swfile!"
        docker run -v ${PASSED}:/data dprasad/swf-to-mp4 $swfile
    done
elif [ -f "${PASSED}" ]; then
    FULLPATH=$(readlink -f "${PASSED}")
    BASEDIR=$(dirname "${FULLPATH}")
    FILENAME=$(basename "${FULLPATH}")
    echo "Filename: " + $FILENAME
    echo "BASEDIR: "+ $BASEDIR
    docker run -it -v "$BASEDIR":/data dprasad/swf-to-mp4 ${FILENAME}
else
    echo "Not a valid file/directory."
 $1
fi

