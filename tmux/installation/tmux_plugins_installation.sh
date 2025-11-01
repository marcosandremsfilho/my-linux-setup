#!/bin/bash

ORIG_USER=$SUDO_USER
ORIG_HOME=$(eval echo "~$ORIG_USER")

echo "Creating the catppuccin folder on tmux/plugins ..."
mkdir -p $ORIG_HOME/.config/tmux/plugins/catppuccin/

echo "Cloning the catppuccin theme on the tmux plugins folder ..."
git clone https://github.com/catppuccin/tmux.git $ORIG_HOME/.config/tmux/plugins/catppuccin/

echo "Getting my tmux config from my repository and "
chown -R $ORIG_USER:$ORIG_USER $ORIG_HOME/.config/tmux

echo "Installing Tmuxifier ..."
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

LINE1='export PATH="$HOME/.tmuxifier/bin:$PATH"'
LINE2='eval "$(tmuxifier init -)"'

add_line_if_missing() {
  local line="$1"
  local file="$2"
  if ! grep -Fxq "$line" "$file"; then
    echo "$line" >> "$file"
    echo "✅ Path added to the bashrc file $file: $line"
  else
    echo "ℹ️ Path already exists in the bashrc file $file: $line"
  fi
}

add_line_if_missing "$LINE1" "$BASHRC"
add_line_if_missing "$LINE2" "$BASHRC"

echo "Installing the TPM plugin ..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Applying plugins ..."
~/.tmux/plugins/tpm/scripts/install_plugins.sh

