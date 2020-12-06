#!/usr/bin/env bash

echo "-------------------------------------------------"
echo "-------select your disk to format----------------"
echo "-------------------------------------------------"
lsblk
read -p "Please enter disk (example /dev/sda): " DISK

if [ -z "$DISK" ]; then
    echo "Error: No disk have been selected."
    exit 1;
fi

read -p "Please enter the size for the root partition \"/\" in GB (default 20): " ROOTSIZE
if [ -z "$ROOTSIZE" ]; then
    ROOTSIZE=20
fi

read -p "Please enter the size of the swap file in GB (default 4): " SWAPSIZE 
if [ -z $SWAPSIZE ]; then
    SWAPSIZE=4
fi

echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download - CA Only"
echo "-------------------------------------------------"
timedatectl set-ntp true
pacman -S --noconfirm pacman-contrib
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://www.archlinux.org/mirrorlist/?country=CA&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist


echo -e "\nInstalling prereqs...\n$HR"
pacman -S --noconfirm gptfdisk btrfs-progs

echo "--------------------------------------"
echo -e "\nFormatting disk...\n$HR"
echo "--------------------------------------"

# disk prep
sgdisk -Z ${DISK} # zap all on disk
sgdisk -a 2048 -o ${DISK} # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:+500M         ${DISK} # partition 1 (UEFI SYS), default start block, 500MB
sgdisk -n 2:0:+${SWAPSIZE}G ${DISK} # partition 2 (Swap), default start, 4G
sgdisk -n 3:0:+${ROOTSIZE}G ${DISK} # partition 3 (Root), default start, 20G
sgdisk -n 4:0:0             ${DISK} # partition 4 (Home), default start, remaining

# set partition types
sgdisk -t 1:ef00 ${DISK}
sgdisk -t 2:8200 ${DISK}
sgdisk -t 3:8300 ${DISK}
sgdisk -t 4:8300 ${DISK}

# label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"SWAP" ${DISK}
sgdisk -c 3:"ROOT" ${DISK}
sgdisk -c 4:"HOME" ${DISK}

# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"
mkswap -L "SWAP" "${DISK}2"
mkfs.ext4 -L "ROOT" "${DISK}3"
mkfs.ext4 -L "HOME" "${DISK}4"

swapon "${DISK}2"

# mount target
mkdir /mnt
mount -t ext4 "${DISK}2" /mnt
mkdir -p /mnt/boot/efi
mount -t vfat "${DISK}1" /mnt/boot
mkdir /mnt/home
mount -t ext4 "${DISK}3" /mnt/home

echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"
pacstrap /mnt base base-devel linux linux-firmware sudo --noconfirm --needed
genfstab -U /mnt >> /mnt/etc/fstab
echo "${DISK}2 swap swap defaults 0 0" >> /mnt/etc/fstab

mv chroot.sh /mnt
arch-chroot /mnt /bin/bash -c "./chroot.sh ${DISK}2"
umount -R /mnt

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"
