#!/bin/bash

check_retvar()
{
    if [ $? -ne 0 ]; then
        echo The last operation ${1} failed!
    fi
}

if [ $# -ne 1 ]; then
    echo Wrong number of option you input.
    exit -1
fi

# Create a new account
echo Create a new account
sudo adduser ${1}
check_retvar adduser

# Add the samba access password
echo Add the samba access password
sudo smbpasswd -a ${1}
check_retvar smbpasswd

