#!/bin/bash

PREFIX=bjo-eng-bld
SUFFIX=dolby.net
DEFAULT=3 
USERNAME=clu

echo "Will connect to ${PREFIX}-0x servers"
echo "Please choose the ID of servers, 0 ~ 8 are available"

read index

if [ "${index}" == "" ]; then
    echo "You didn't input anything, will connect to ${PREFIX}-0${DEFAULT} by default"
    index=${DEFAULT}
fi

if [ $((index)) -lt 0 ] || [ $((index)) -gt 8 ]; then
    echo The ID you input is invalid: ${index}
fi

echo "Please input you login ID, default is ${USERNAME}"
read user
if [ "${user}" == "" ]; then
    echo "You didn't input anything, will use ${USERNAME} by default"
    user=${USERNAME}
fi

set -x
#ssh -X ${user}@${PREFIX}-0${index}.${SUFFIX}
ssh ${user}@${PREFIX}-0${index}.${SUFFIX}
