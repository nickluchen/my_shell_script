#!/bin/bash

clu_desktop_ip='10.204.5.190'
bjo_file_server=bjo-file-01.dolby.net
bjo_bld_server=bjo-eng-bld-01.dolby.net 

base_dir=/Volumes

clu_desktop_home=${base_dir}/clu-desktop-home
clu_domain_home=${base_dir}/clu-domain-home
clu_bld_home=${base_dir}/clu-bld-home


if [ "`uname -s`" = "Linux" ]; then
  # You must set the CLU_DOMAIN_PW environment variable prior to executing this
  # script otherwise it will choose the default password.
  if [ "$CLU_DOMAIN_PW" == "" ]; then
    echo "You didn't set the envrionment variable CLU_DOMAIN_PW."
    echo "Will use the default one, it might be incorrect."
    WINPW=Dolby-730
  else
    WINPW=$CLU_DOMAIN_PW
  fi

  if [[ "${WINPW}" == *\,* ]]; then
    echo The password is including the comma sign (,)
    echo You should pass the password manually, for each mount command.
    PASSWD_OPTION=""
  else
    PASSWD_OPTION="passwd=$WINPW"
  fi
  sudo_cmd='sudo'
elif [ "`uname -s`" = "Darwin" ]; then
  sudo_cmd=' '
fi

##### Helper functions #####
check_and_mkdir()
{
  if [ ! -d $1 ]; then
    ${sudo_cmd} mkdir -p $1
  fi
}

check_and_mount()
{
    if [ -z "`mount | grep $4`" ]; then
        $1 $2 $3 $4 $5
    else
        echo "Mount point $4 already mounted. Skip."
    fi
}


##### Main #####

check_and_mkdir ${clu_desktop_home}
check_and_mkdir ${clu_domain_home}
check_and_mkdir ${clu_bld_home}

if [ "$1" = "umount" ] || [ "$1" = "u" ]
then
    ${sudo_cmd} umount ${clu_bld_home}
    ${sudo_cmd} umount ${clu_domain_home}
    ${sudo_cmd} umount ${clu_desktop_home}
else
    if [ "`uname -s`" = "Linux" ]
    then
        check_and_mount "${sudo_cmd} mount" "-t cifs" //${bjo_file_server}/users/clu ${clu_domain_home} "-o user=clu,domain=DOLBYNET,uid=clu,gid=clu,$PASSWD_OPTION"
        check_and_mount "${sudo_cmd} mount" "-t cifs" //${bjo_bld_server}/clu ${clu_bld_home} "-o user=clu,domain=DOLBYNET,uid=clu,gid=clu,$PASSWD_OPTION"
        if [ "`hostname`" != "clu-desktop" ]; then
          check_and_mount "${sudo_cmd} mount" "-t nfs -o nolock" ${clu_desktop_ip}:/home/clu ${clu_desktop_home}
        fi
    elif [ "`uname -s`" = "Darwin" ]
    then
        check_and_mount "mount" "-t smbfs" //clu@${bjo_bld_server}/clu        ${clu_bld_home}
        check_and_mount "mount" "-t smbfs" //clu@${bjo_file_server}/users/clu ${clu_domain_home}
        check_and_mount "mount" "-t smbfs" //clu@${clu_desktop_ip}/clu        ${clu_desktop_home}
    fi
    mount | grep clu
fi

