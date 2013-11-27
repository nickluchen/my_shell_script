#!/bin/bash

#du -h --max-depth=1|grep "\<[1-9]\{1,\}G"

if [ -n "${1}" ]; then
    CURRENT_USER=${1}
elif [ -n "${USER}" ]; then
    CURRENT_USER=${USER}
else
    echo "Unknown user."
fi

TEMP_FILE=/tmp/${CURRENT_USER}_temp.txt
du --max-depth=1 -h > ${TEMP_FILE}

echo Listing by size
for unit in T G M K; do  
    cat ${TEMP_FILE} | grep -e "[0-9]${unit}"|sort -nr -k 1
done

rm ${TEMP_FILE}
