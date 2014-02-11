#!/bin/bash

if [ "$1" = "umount" ] || [ "$1" = "u" ]
then
	cmd=umount
	${cmd} bld-home
	${cmd} clu-desktop
else
	cmd=mount
    ${cmd} -t smbfs //clu@bjo-eng-bld-01/clu bld-home/
    ${cmd} -t smbfs //clu@10.204.5.190/clu clu-desktop/
fi

