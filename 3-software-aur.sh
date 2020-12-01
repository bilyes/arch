#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Error: Please provide the location where yay should be installed"
    echo "Example: ./3-software-aur.sh /home/test"
    exit 1;
fi

echo -e "\nINSTALLING AUR SOFTWARE\n"

git clone "https://aur.archlinux.org/yay.git" $1/yay

PKGS=(
    'nerd-fonts-fira-code'
    'nerd-fonts-roboto-mono'
    'nerd-fonts-inconsolata'
    'nerd-fonts-mononoki'
    'i3lock-fancy'
)

cd $1/yay
makepkg -si

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo -e "\nDone!\n"
