#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Error: Please provide user to configure"
    echo "Example: ./9-configuration.sh test"
    exit;
fi


echo -e "\nFINAL SETUP AND CONFIGURATION"

# ------------------------------------------------------------------------

echo -e "\nGenerating .xinitrc file"

# Generate the .xinitrc file so we can launch Awesome from the
# terminal using the "startx" command
cat <<EOF > /home/$1/.xinitrc
#!/bin/bash
# Disable bell
xset -b

# Disable all Power Saving Stuff
xset -dpms
xset s off

# X Root window color
xsetroot -solid darkgrey

# Merge resources (optional)
#xrdb -merge /home/$1/.Xresources

# Caps to Ctrl, no caps
setxkbmap -layout us -option ctrl:nocaps
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "\$f" ] && . "\$f"
    done
    unset f
fi

exit 0
EOF

# ------------------------------------------------------------------------

echo -e "\nUpdating /bin/startx to use the correct path"

# By default, startx incorrectly looks for the .serverauth file in our HOME folder.
sed -i 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

# ------------------------------------------------------------------------

echo -e "\nConfiguring LTS Kernel as a secondary boot option"

sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf
sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf

# ------------------------------------------------------------------------

echo -e "\nConfiguring vconsole.conf to set a larger font for login shell"

sudo cat <<EOF > /etc/vconsole.conf
KEYMAP=us
FONT=ter-v32b
EOF

# ------------------------------------------------------------------------

echo -e "\nDisabling buggy cursor inheritance"

# When you boot with multiple monitors the cursor can look huge. This fixes it.
sudo cat <<EOF > /usr/share/icons/default/index.theme
[Icon Theme]
#Inherits=Theme
EOF

# ------------------------------------------------------------------------

echo -e "\nIncreasing file watcher count"

# This prevents a "too many files" error in Visual Studio Code
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

# ------------------------------------------------------------------------

echo -e "\nDisabling Pulse .esd_auth module"

# Pulse audio loads the `esound-protocol` module, which best I can tell is rarely needed.
# That module creates a file called `.esd_auth` in the home directory which I'd prefer to not be there. So...
sed -i 's|load-module module-esound-protocol-unix|#load-module module-esound-protocol-unix|g' /etc/pulse/default.pa

# ------------------------------------------------------------------------
# Set default shell
usermod -s /bin/zsh $1

# ------------------------------------------------------------------------

#echo -e "\nEnabling bluetooth daemon and setting it to auto-start"

#sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf
#sudo systemctl enable --now bluetooth.service

# ------------------------------------------------------------------------

#echo -e "\nEnabling the cups service daemon so we can print"

#systemctl enable --now org.cups.cupsd.service
#sudo ntpd -qg
#sudo systemctl enable --now ntpd.service
#sudo systemctl disable dhcpcd.service
#sudo systemctl stop dhcpcd.service
#sudo systemctl enable --now NetworkManager.service

# Clean orphans pkg
orphans=$(pacman -Qdt)
if [[ ! -n $orphans ]]; then
	echo "No orphans to remove."
else
	pacman -Rns $orphans
fi

# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Enable and start the display manager
echo -e "\nEnabling Login Display Manager"
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
systemctl enable --now lightdm.service

echo "
###############################################################################
# Done
###############################################################################
"
