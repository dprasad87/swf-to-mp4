#!/bin/bash


if [ $# -ne 1 ]; then
    echo "Usage: convert.sh input.swf"
    echo "will produce input.mp4 as output"
    exit 1
fi

function process_single_file() {
    swfile=$1
    FULLPATH=$(readlink -f "${swfile}")
    BASEDIR=$(dirname "${FULLPATH}")
    FILENAME=$(basename "${FULLPATH}")
    echo "Filename: " + $FILENAME
#    echo "BASEDIR: "+ $BASEDIR
    docker run -v ${PASSED}:/data dprasad/swf-to-mp4 $swfile
    echo "......File stored as $BASEDIR/${FILENAME%.*}.mp4"
    echo "------------------------------------------------"
}

PASSED=$1

if [ -d "${PASSED}" ]; then
    echo "To convert files in directory: ${PASSED}"
    for swfile in ${PASSED}/*.swf
        do
        echo "Converting $swfile!"
        process_single_file ${swfile}
    done
elif [ -f "${PASSED}" ]; then
    process_single_file ${PASSED}
else
    echo "Not a valid file/directory." $1
fi

