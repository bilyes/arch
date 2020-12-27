#!/bin/bash

# Enable and start the display manager
echo -e "\nEnabling Login Display Manager"
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
systemctl enable --now lightdm.service
