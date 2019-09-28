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
    echo "File ${PASSED} was passed."
    docker run -v $(dirname $(readlink -f ${PASSED})):/data dprasad/swf-to-mp4 ${PASSED}
else
    echo "Not a valid file/directory."
 $1
fi

