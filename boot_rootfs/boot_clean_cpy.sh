#!/bin/bash
#startarg build: buildfolder name in yocto, default is build

if [ $# -ne 1 ];then
  echo Need builddir name as argument
  exit 1
fi

build=$1
echo clean and copy from buildmachine to sdcard 
rm ~/boot/*
scp user@buildmachine:/home/username/git/poky/$build/tmp/deploy/images/beaglebone/zImage ~/boot/
scp user@buildmachine:/home/username/git/poky/$build/tmp/deploy/images/beaglebone/MLO ~/boot/
scp user@buildmachine:/home/username/git/poky/$build/tmp/deploy/images/beaglebone/u-boot.img ~/boot/
scp user@buildmachine:/home/username/git/poky/$build/tmp/deploy/images/beaglebone/zImage-am335x-boneblack.dtb ~/boot/
ls -al ~/boot/
rm /media/$USER/boot/*
cd /media/$USER/boot
cp ~/boot/* .
#sudo tar -xf ~/boot/*.rootfs*.bz2 .
ls -al /media/$USER/boot
echo script complete


