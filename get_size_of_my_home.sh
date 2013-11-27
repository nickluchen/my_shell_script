#!/bin/bash

if [ -n "${1}" ]; then
    CURRENT_USER=${1}
elif [ -n "${USER}" ]; then
    CURRENT_USER=${USER}
else
    echo "Unknown user."
fi

TEMP_FILE=/tmp/${CURRENT_USER}_home_size_temp.txt

cd ${HOME} || exit 2

echo '##################################'
echo Today is: `date -R`
echo '##################################'

du --max-depth=1 -h > ${TEMP_FILE}

echo ========================================
echo " We are in `pwd -P`"
echo ----------------------------------------
#echo -e #print a blank line.
echo Listing by size
for unit in T G M K; do 
    cat ${TEMP_FILE} | grep -e "[0-9]${unit}"|sort -nr -k 1
done
echo ========================================
