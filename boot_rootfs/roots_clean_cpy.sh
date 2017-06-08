#!/bin/bash

#startarg build: buildfolder name in yocto, default is build

if [ $# -ne 1 ];then
  echo Need builddir name as argument
  exit 1
fi

build=$1

echo clean and copy from buidmachine to sdcard 
rm ~/rootfs/*
scp user@buildmachine:/home/username/git/poky/$build/tmp/deploy/images/beaglebone/*.bz2 ~/rootfs/
ls -al ~/rootfs/
sudo rm -rf /media/$USER/rootfs/*
cd /media/$USER/rootfs
sudo tar -xf ~/rootfs/*.rootfs*.bz2 .
ls -al /media/$USER/rootfs
echo script complete

