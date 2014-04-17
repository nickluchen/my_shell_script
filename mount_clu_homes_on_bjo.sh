#!/bin/bash

clu_desktop_ip='10.204.5.190'

linux_base_dir=/home/clu
mac_base_dir=/Users/Shared/clu

if [ "`uname -s`" = "Linux" ]
then
    clu_desktop_home=${linux_base_dir}/clu-desktop-home
    clu_bld_home=${linux_base_dir}/clu-bld-home
elif [ "`uname -s`" = "Darwin" ]
then
    clu_desktop_home=${mac_base_dir}/clu-desktop-home
    clu_bld_home=${mac_base_dir}/clu-bld-home
else
then
    echo "Unknown OS. Will quit."
    exit -1
fi


if [ "$1" = "umount" ] || [ "$1" = "u" ]
then
    if [ "`uname -s`" = "Linux" ]
    then
        cmd='sudo umount'
    elif [ "`uname -s`" = "Darwin" ]
    then
        cmd=umount
        ${cmd} ${clu_bld_home}
    fi
    ${cmd} ${clu_desktop_home}
else
    if [ "`uname -s`" = "Linux" ]
    then
        cmd='sudo mount'
        # ${cmd} -t cifs //10.204.5.190/clu /home/clu/clu-desktop/ -o user=clu,uid=clu
        ${cmd} -t nfs -o nolock ${clu_desktop_ip}:/home/clu ${clu_desktop_home}
    elif [ "`uname -s`" = "Darwin" ]
    then
        cmd=mount
        ${cmd} -t smbfs //clu@bjo-eng-bld-01/clu     ${clu_bld_home}
        ${cmd} -t smbfs //clu@${clu_desktop_ip}/clu  ${clu_desktop_home}
    fi
    mount | grep clu
fi

