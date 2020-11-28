#!/usr/bin/env bash

if [ -z $1 ]; then
    echo "Error: Please provide a disk. Example: ./chroot.sh /dev/sda1"
fi

# Bootloader systemd installation
bootctl install
cat <<EOF > /boot/loader/entries/arch.conf
title Arch Linux  
linux /vmlinuz-linux  
initrd  /initramfs-linux.img  
options root=${1} rw
EOF

# Network setup
pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

echo "--------------------------------------"
echo "--      Set Password for Root       --"
echo "--------------------------------------"
echo "Enter password for root user: "
passwd root

