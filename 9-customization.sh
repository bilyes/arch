#!/bin/bash

# Awesome Window Manager
git clone https://github.com/ilyessbachiri/material-awesome ~/.config/awesome

# Dot files
git clone https://github.com/ilyessbachiri/dotfiles.git ~/.config/dotfiles \
    && ~/.config/dotfiles/install.sh

# Terminal
pip install powerline-status
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


