#!/bin/bash

apt install npm
apt install ripgrep # This dependencie is used to enable the live grep from telescope
apt install xclip # This dependencie is used to enable the copy and paste from outside the editor

ORIG_USER=$SUDO_USER
ORIG_HOME=$(eval echo "~$ORIG_USER")

# Installing catppuccin theme
mkdir -p $ORIG_HOME/.config/tmux/plugins/catppuccin/tmux

git clone https://github.com/catppuccin/tmux.git $ORIG_HOME/.config/tmux/plugins/catppuccin/tmux

chown -R $ORIG_USER:$ORIG_USER $ORIG_HOME/.config/tmux

# Installing Tmuxfier
# Need to remember to add the export PATH="$HOME/.tmuxifier/bin:$PATH" and the eval "$(tmuxifier init -)" in the config
# file (in my case .bashrc)
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

# Installing TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

~/.tmux/plugins/tpm/scripts/install_plugins.sh
