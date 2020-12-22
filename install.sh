#!/usr/bin/env bash

read -p "Please enter hostname: " hostname
read -p "Please enter username: " username
# Add user
useradd -m -G wheel $username
echo "Set the password for the user $username"
passwd $username

pacman -S --noconfirm pacman-contrib curl

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://www.archlinux.org/mirrorlist/?country=CA&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

nc=$(grep -c ^processor /proc/cpuinfo)
echo "Changing the makeflags for "$nc" cores."
sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$nc"/g' /etc/makepkg.conf
echo "Changing the compression settings for "$nc" cores."
sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g' /etc/makepkg.conf

echo "Setup language and locale"
sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone America/Montreal
timedatectl --no-ask-password set-ntp 1
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"

# Set keymaps
localectl --no-ask-password set-keymap us

# Hostname
hostnamectl --no-ask-password set-hostname $hostname


# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

# Move AUR instlalation script to the user's home folder
mv 3-software-aur.sh /home/$username/
./1-base.sh
runuser -l $username -c "./3-software-aur.sh /home/$username"

./8-configuration.sh $username

runuser -l $username -c "./9-customization.sh"

./99-start.sh

