#!/usr/bin/env bash

echo -e "\nInstalling Base System\n"

PKGS=(

    # --- XORG Display Rendering
        'xorg'                  # Base Package
        'xorg-drivers'          # Display Drivers 
        'xterm'                 # Terminal for TTY
        'xorg-server'           # XOrg server
        'xorg-apps'             # XOrg apps group
        'xorg-xinit'            # XOrg init
        'xorg-xinput'           # Xorg xinput
        'mesa'                  # Open source version of OpenGL

    # --- Setup Desktop
        'awesome'               # Awesome Desktop
        'rofi'                  # Menu System
        'picom'                 # Translucent Windows
        'xclip'                 # System Clipboard
        'gnome-polkit'          # Elevate Applications
        'lxappearance'          # Set System Themes

    # --- Login Display Manager
        'lightdm'                   # Base Login Manager
        'lightdm-webkit2-greeter'   # Framework for Awesome Login Themes

    # --- Networking Setup
        'wpa_supplicant'            # Key negotiation for WPA wireless networks
        'dialog'                    # Enables shell scripts to trigger dialog boxex
        'openvpn'                   # Open VPN support
        'libsecret'                 # Library for storing passwords
    
    # --- Audio
        'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
        'alsa-plugins'      # ALSA plugins
        'pulseaudio'        # Pulse Audio sound components
        'pulseaudio-alsa'   # ALSA configuration for pulse audio
        'pavucontrol'       # Pulse Audio volume control

    # --- Bluetooth
        #'bluez'                 # Daemons for the bluetooth protocol stack
        #'bluez-utils'           # Bluetooth development and debugging utilities
        #'bluez-firmware'        # Firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips
        #'blueberry'             # Bluetooth configuration tool
        #'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
    
    # --- Printers
        #'cups'                  # Open source printer drivers
        #'cups-pdf'              # PDF support for cups
        #'ghostscript'           # PostScript interpreter
        #'gsfonts'               # Adobe Postscript replacement fonts
        #'hplip'                 # HP Drivers
        #'system-config-printer' # Printer setup  utility

    # SYSTEM --------------------------------------------------------------

        'linux-lts'             # Long term support kernel
        'htop'                  # Process viewer
        'ntp'                   # Network Time Protocol to set time via network.
        'openssh'               # SSH connectivity tools
        'ntfs-3g'               # Open source implementation of NTFS file system

    # DEVELOPMENT ---------------------------------------------------------

        'clang'                 # C Lang compiler
        'cmake'                 # Cross-platform open-source make system
        'vim'                   # The best editor
        'python-pip'            # Python package manager

    # TERMINAL ---------------------------------------------------------
        'zsh'
        'alacritty'
        'tmux'
        'picom'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nDone!\n"
