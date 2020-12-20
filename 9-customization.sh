#!/bin/bash

# Awesome Window Manager
git clone https://github.com/ilyessbachiri/material-awesome ~/.config/awesome &

# Terminal
(pip install powerline-status && pip install powerline-mem-segment) &
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Dot files
git clone https://github.com/ilyessbachiri/dotfiles.git ~/.config/dotfiles \
    && ~/.config/dotfiles/install.sh

wait
