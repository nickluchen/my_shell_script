#!/bin/bash

# Before setting up the RAID
#sudo mount -t ntfs-3g /dev/sda1 /home/smbshare_1 
#sudo mount -t ntfs-3g /dev/sdb1 /home/smbshare_2 

#mount | grep "/dev/sd"

sudo mount -t ext4 /dev/md0 /home/smbshare_1
mount | grep "/dev/md"
