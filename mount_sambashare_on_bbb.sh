#!/bin/bash

sudo mount -t ext4 /dev/sda1 /home/data-1 
sudo mount -t ext4 /dev/sda2 /home/data-2 

mount | grep "/dev/sd"
