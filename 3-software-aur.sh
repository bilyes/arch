#!/usr/bin/env bash

echo -e "\nINSTALLING AUR SOFTWARE\n"

git clone "https://aur.archlinux.org/yay.git" $HOME/

PKGS=(
# list packages here
)

cd ${HOME}/yay
makepkg -si

if [ ${#PKGS[@]} -gt 0 ]; then
    yay -S "${PKGS[@]}" --noconfirm
fi

echo -e "\nDone!\n"
