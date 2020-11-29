#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Error: Please provide the location where yay should be installed"
    echo "Example: ./3-software-aur.sh /home/test"
    exit;
fi

echo -e "\nINSTALLING AUR SOFTWARE\n"

exit;

git clone "https://aur.archlinux.org/yay.git" $1/

PKGS=(
# list packages here
)

cd ${1}/yay
makepkg -si

if [ ${#PKGS[@]} -gt 0 ]; then
    yay -S "${PKGS[@]}" --noconfirm
fi

echo -e "\nDone!\n"
