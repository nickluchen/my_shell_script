#!/bin/bash


if [ "$1" = "umount" ] || [ "$1" = "u" ]
then
    if [ "`uname -s`" = "Linux" ]
    then
        cmd='sudo umount'
    elif [ "`uname -s`" = "Darwin" ]
    then
        cmd=umount
        ${cmd} bld-home
    fi
	${cmd} clu-desktop
else
    if [ "`uname -s`" = "Linux" ]
    then
        cmd='sudo mount'
        # ${cmd} -t cifs //10.204.5.190/clu /home/clu/clu-desktop/ -o user=clu,uid=clu
        sudo mount -t nfs -o nolock 10.204.5.190:/home/clu /home/clu/clu-desktop/
    elif [ "`uname -s`" = "Darwin" ]
    then
        cmd=mount
        ${cmd} -t smbfs //clu@bjo-eng-bld-01/clu bld-home/
        ${cmd} -t smbfs //clu@10.204.5.190/clu clu-desktop/
    fi
fi

