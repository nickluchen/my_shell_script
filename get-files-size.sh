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

# Get the size of each directory
du --max-depth=1 -h > ${TEMP_FILE}
# Add the tailing / to each item
sed -i 's/$/&\//g' ${TEMP_FILE}

# Get the size of each file, excluding directories
ls -ahlS -1 -F | grep -v "/$" | awk '{print $5" \t./" $(9)}' >> ${TEMP_FILE}


echo Listing by size
for unit in T G M K; do  
    cat ${TEMP_FILE} | grep -e "[0-9]${unit}"|sort -nr -k 1
done

rm ${TEMP_FILE}
