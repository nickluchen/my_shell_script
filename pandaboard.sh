#! /bin/bash

# Last update: 2013/4/25

# Pandaboard's IP, username and password can be found at:
# http://confluence.dolby.net/kb/display/lechin/IT#IT-LECHNARMEcosystemFixed%28Static%29IPassignment%28Overridesabovetableifconflict%29

if [ -z "$1" -o "$1" == "-h" ]; then
    echo You must pass a digit to indicate which panda board will be connected.
    exit
elif [ $1 -lt 1 ] || [ $1 -gt 12 ]; then
    echo "The valid panda IDs are 1~12. (Engineer team)"
    exit
#elif [ $1 -eq 5 ]; then
#    echo "Panda 5 is missing! Unavailable."
#    exit
fi

# Set IP
IPBASE=113
if [ $1 -lt 6 ]; then
	OFFSET=0
elif [ $1 -lt 8 ]; then
	OFFSET=5
elif [ $1 -eq 8 ]; then
	OFFSET=7
elif [ $1 -lt 13 ]; then
	OFFSET=10
fi

# Set username and password
if [ $1 -lt 8 ]; then
	USERNAME=panda${1}	
	PW=dolby1234
elif [ $1 -lt 13 ]; then
	USERNAME=ubuntu
	PW=ubuntu
fi

PANDAIP=10.204.5.$(($IPBASE+$OFFSET+$1))
echo ssh to ${PANDAIP}, ID:${USERNAME} PW:${PW}

#use expect tool
./ssh_cmd.sh ssh ${USERNAME}@${PANDAIP} ${PW}

