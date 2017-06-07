#!/bin/bash

build=$1
echo clean and copy from embeddedsolutions.se to sdcard 
rm ~/boot/*
scp rodz@embeddedsolutions.se:/home/rodz/git/poky/$build/tmp/deploy/images/beaglebone/zImage ~/boot/
scp rodz@embeddedsolutions.se:/home/rodz/git/poky/$build/tmp/deploy/images/beaglebone/MLO ~/boot/
scp rodz@embeddedsolutions.se:/home/rodz/git/poky/$build/tmp/deploy/images/beaglebone/u-boot.img ~/boot/
scp rodz@embeddedsolutions.se:/home/rodz/git/poky/$build/tmp/deploy/images/beaglebone/zImage-am335x-boneblack.dtb ~/boot/
ls -al ~/boot/
rm /media/$USER/boot/*
cd /media/$USER/boot
cp ~/boot/* .
#sudo tar -xf ~/boot/*.rootfs*.bz2 .
ls -al /media/$USER/boot
echo script complete

