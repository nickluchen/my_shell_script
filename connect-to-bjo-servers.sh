#!/bin/bash

PREFIX=bjo-eng-bld
SUFFIX=dolby.net
DEFAULT=3 
USERNAME=clu
show_info=1

if [ "$1" != "" ]
then
    index=$1
else
	echo "Will connect to ${PREFIX}-0x servers"
	echo "Please choose the ID of servers, 0 ~ 10 are available"

	read index

	if [ "${index}" == "" ]; then
		echo "You didn't input anything, will connect to \
                  ${PREFIX}-0${DEFAULT} by default"
		index=${DEFAULT}
	fi
    show_info=0
fi

if [ $((index)) -lt 0 ] || [ $((index)) -gt 10 ]; then
	echo The ID you input is invalid: ${index}
else
	if [ $((index)) -lt 10 ]
	then
		index=0${index}
	fi
    if [ $((show_info)) -ne 0 ]
    then
        echo "Will connect to ${PREFIX}-${index} server"
    fi
fi


echo "Please input you login ID, default is ${USERNAME}"
read user
if [ "${user}" == "" ]; then
    echo "You didn't input anything, will use ${USERNAME} by default"
    user=${USERNAME}
fi

set -x
#ssh -X ${user}@${PREFIX}-${index}.${SUFFIX}
ssh ${user}@${PREFIX}-${index}.${SUFFIX}
