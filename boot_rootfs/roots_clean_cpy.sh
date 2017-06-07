#!/bin/bash

build=$1

echo clean and copy from buidmachine to sdcard 
rm ~/rootfs/*
scp user@buildmachine:/home/rodz/git/poky/$build/tmp/deploy/images/beaglebone/*.bz2 ~/rootfs/
ls -al ~/rootfs/
sudo rm -rf /media/$USER/root/*
cd /media/$USER/root
sudo tar -xf ~/rootfs/*.rootfs*.bz2 .
ls -al /media/$USER/root
echo script complete

