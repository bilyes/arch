#!/usr/bin/env bash

echo -e "\nINSTALLING AUR SOFTWARE\n"

git clone "https://aur.archlinux.org/yay.git" $HOME/

PKGS=(
# list packages here
)

cd ${HOME}/yay
makepkg -si

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo -e "\nDone!\n"
