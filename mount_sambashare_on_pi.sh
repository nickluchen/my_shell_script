#!/bin/bash

sudo mount -t ntfs-3g /dev/sda1 /home/smbshare_1 
sudo mount -t ntfs-3g /dev/sdb1 /home/smbshare_2 

mount | grep "/dev/sd"
