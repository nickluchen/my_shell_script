#! /bin/bash

#set -x

# You must set the CLU_DOMAIN_PW environment variable prior to executing this
# script otherwise it will choose the default password.
if [ "$CLU_DOMAIN_PW" == "" ]; then
    echo "You didn't set the envrionment variable CLU_DOMAIN_PW."
    echo "Will use the default one, it might be incorrect."
    WINPW=Dolby-730
else
    WINPW=$CLU_DOMAIN_PW
fi

SAMBAPW=123456
BJO_FILE_SERVER=bjo-file-01.dolby.net
BJO_ENG_SERVER=bjo-eng-bld-03.dolby.net

#RUNLEVEL=`runlevel|awk '{print $NF}'`
#if [ "$RUNLEVEL" -eq 5 ]; then
#    nautilus smb://${BJO_ENG_SERVER}/clu
#    nautilus smb://${BJO_FILE_SERVER}/users/clu
#fi

if [ "$1" == "umount" ]
then
    for mount_item in `mount | grep bjo- | awk '{ print $1 }'`
    do
        sudo umount ${mount_item}
    done
    exit 0
fi

if [ ! -d /Volumes/${BJO_ENG_SERVER}_clu ]; then
    sudo mkdir -p /Volumes/${BJO_ENG_SERVER}_clu
fi
if [ ! -d /data ]; then
    sudo mkdir -p /data
fi
if [ ! -d /mnt/${BJO_FILE_SERVER}_clu ]; then
    sudo mkdir -p /mnt/${BJO_FILE_SERVER}_clu
fi
if [ ! -d /mnt/${BJO_FILE_SERVER}/Projects ]; then
    sudo mkdir -p /mnt/${BJO_FILE_SERVER}/Projects
fi
if [ ! -d /mnt/${BJO_FILE_SERVER}/Common ]; then
    sudo mkdir -p /mnt/${BJO_FILE_SERVER}/Common
fi
if [ ! -d /mnt/${BJO_FILE_SERVER}/Source ]; then
    sudo mkdir -p /mnt/${BJO_FILE_SERVER}/Source
fi

if [ -z "`mount | grep ${BJO_FILE_SERVER}_clu`" ]; then
    sudo mount -t cifs \
        //${BJO_FILE_SERVER}/users/clu \
        /mnt/${BJO_FILE_SERVER}_clu \
        -o user=clu,domain=DOLBYNET,passwd=$WINPW,uid=clu,gid=clu
fi
if [ -z "`mount | grep Projects`" ]; then
    sudo mount -t cifs \
        //${BJO_FILE_SERVER}/Projects \
        /mnt/${BJO_FILE_SERVER}/Projects \
        -o user=clu,domain=DOLBYNET,passwd=$WINPW
fi
if [ -z "`mount | grep Common`" ]; then
    sudo mount -t cifs \
        //${BJO_FILE_SERVER}/Users/Common \
        /mnt/${BJO_FILE_SERVER}/Common \
        -o user=clu,domain=DOLBYNET,passwd=$WINPW
fi
if [ -z "`mount | grep Source`" ]; then
    sudo mount -t cifs \
        //${BJO_FILE_SERVER}/Source \
        /mnt/${BJO_FILE_SERVER}/Source \
        -o user=clu,domain=DOLBYNET,passwd=$WINPW
fi
if [ -z "`mount | grep ${BJO_ENG_SERVER}/data`" -a "$1" == "data" ]; then
    sudo mount -t cifs \
        //${BJO_ENG_SERVER}/data \
        /data \
        -o user=clu,domain=DOLBYNET,passwd=$WINPW,uid=clu,gid=clu
fi
if [ -z "`mount | grep ${BJO_ENG_SERVER}/clu`" ]; then
    sudo mount -t cifs \
        //${BJO_ENG_SERVER}/clu \
        /Volumes/clu \
        -o user=clu,domain=DOLBYNET,passwd=$WINPW,uid=clu,gid=clu
fi

mount | grep bjo

