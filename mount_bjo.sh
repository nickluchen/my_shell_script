#! /bin/bash

#set -x

if [ "$CLU_DOMAIN_PW" == "" ]; then
    WINPW=Dolby-730
else
    WINPW=$CLU_DOMAIN_PW
fi

SAMBAPW=123456
BJO_SERVER=bjo-file-01.dolby.net
ENGINEER_SERVER=bjo-eng-bld-03.dolby.net

RUNLEVEL=`runlevel|awk '{print $NF}'`

if [ "$RUNLEVEL" -eq 5 ]; then
    nautilus smb://${ENGINEER_SERVER}/clu
    nautilus smb://${BJO_SERVER}/users/clu
fi

if [ ! -d /mnt/${ENGINEER_SERVER}_clu ]; then
    sudo mkdir /mnt/${ENGINEER_SERVER}_clu
fi
if [ ! -d /mnt/${ENGINEER_SERVER}_data ]; then
    sudo mkdir /mnt/${ENGINEER_SERVER}_data
fi
if [ ! -d /mnt/${BJO_SERVER}_clu ]; then
    sudo mkdir /mnt/${BJO_SERVER}_clu
fi
if [ ! -d /mnt/${BJO_SERVER}/Projects ]; then
    #sudo mkdir /mnt/${BJO_SERVER}/
    sudo mkdir -p /mnt/${BJO_SERVER}/Projects
fi
if [ ! -d /mnt/${BJO_SERVER}/Common ]; then
    sudo mkdir -p /mnt/${BJO_SERVER}/Common
fi
if [ ! -d /mnt/${BJO_SERVER}/Source ]; then
    sudo mkdir -p /mnt/${BJO_SERVER}/Source
fi

if [ ! "`mount | grep ${BJO_SERVER}_clu`" ]; then
	sudo mount -t cifs //${BJO_SERVER}/users/clu /mnt/${BJO_SERVER}_clu -o user=clu,domain=DOLBYNET,passwd=$WINPW,uid=clu,gid=clu
fi
if [ ! "`mount | grep Projects`" ]; then
	sudo mount -t cifs //${BJO_SERVER}/Projects /mnt/${BJO_SERVER}/Projects -o user=clu,domain=DOLBYNET,passwd=$WINPW
fi
if [ ! "`mount | grep Common`" ]; then
	sudo mount -t cifs //${BJO_SERVER}/Users/Common /mnt/${BJO_SERVER}/Common -o user=clu,domain=DOLBYNET,passwd=$WINPW
fi
if [ ! "`mount | grep Source`" ]; then
	sudo mount -t cifs //${BJO_SERVER}/Source /mnt/${BJO_SERVER}/Source -o user=clu,domain=DOLBYNET,passwd=$WINPW
fi
sudo mount -t cifs //${ENGINEER_SERVER}/data /mnt/${ENGINEER_SERVER}_data -o user=clu,domain=DOLBYNET,passwd=$WINPW,uid=clu,gid=clu
sudo mount -t cifs //${ENGINEER_SERVER}/clu /Volumes/clu -o user=clu,domain=DOLBYNET,passwd=$WINPW,uid=clu,gid=clu

    
